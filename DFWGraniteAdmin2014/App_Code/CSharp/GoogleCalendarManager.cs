using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.IO;
using System.Threading;
using Google.Apis.Calendar.v3;
using Google.Apis.Calendar.v3.Data;
using Google.Apis.Auth.OAuth2;
using Google.Apis.Auth.OAuth2.Flows;
using Google.Apis.Auth.OAuth2.Web;
using Google.Apis.Services;
using Google.Apis.Util.Store;



public class GoogleCalendarManager
{
        private const string UserId = "dfwgranite";
        private static string gFolder = System.Web.HttpContext.Current.Server.MapPath("/") + "App_Data\\MyGoogleStorage";

        public static bool GoogleAuthenticate()
        {
            IAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow(
                new GoogleAuthorizationCodeFlow.Initializer
                {
                    ClientSecrets = GetClientConfiguration().Secrets,
                    DataStore = new FileDataStore(gFolder),
                    Scopes = new[] { CalendarService.Scope.Calendar }
                });

            var uri = System.Web.HttpContext.Current.Request.Url.ToString();
            var code = System.Web.HttpContext.Current.Request["code"];
            if (code != null)
            {
                var token = flow.ExchangeCodeForTokenAsync(UserId, code,
                    uri.Substring(0, uri.IndexOf("?")), CancellationToken.None).Result;

                // Extract the right state.
                var oauthState = AuthWebUtility.ExtracRedirectFromState(
                    flow.DataStore, UserId, System.Web.HttpContext.Current.Request["state"]).Result;
                System.Web.HttpContext.Current.Response.Redirect(oauthState);
            }
            else
            {
                var result = new AuthorizationCodeWebApp(flow, uri, uri).AuthorizeAsync(UserId,
                    CancellationToken.None).Result;
                if (result.RedirectUri != null)
                {
                    // Redirect the user to the authorization server.
                    System.Web.HttpContext.Current.Response.Redirect(result.RedirectUri);
                }
                else
                {
                    return true;
                }
            }

            return false;
        }

        public static GoogleClientSecrets GetClientConfiguration()
        {
            using (var stream = new FileStream(gFolder + @"\client_secrets.json", FileMode.Open, FileAccess.Read))
            {
                return GoogleClientSecrets.Load(stream);
            }
        }

}

