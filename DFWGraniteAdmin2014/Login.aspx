<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="DFWGraniteAdmin2014.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script>
        if (window.top !== window.self) {
            $('.navbar').hide();
            $('.container').hide();

            var loc = window.top.location.href, index = loc.indexOf('#');
            if (index > 0)
                window.top.location.replace('/admin2014/Login.aspx?ReturnUrl=' + loc.substring(0, index));
            else
                window.top.location.replace('/admin2014/Login.aspx');
        }
    </script>
    <style>

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
     <div id="loginbox" style="margin-top:50px;" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">                    
            <div class="panel panel-info" >
                    <div class="panel-heading">
                        <div class="panel-title">Sign In</div>
                        <div style="float:right; font-size: 80%; position: relative; top:-15px"><a href="#">Forgot password?</a></div>
                    </div>     

                    <div style="padding-top:30px" class="panel-body" >

                        <asp:Literal ID="LoginAlertLiteral" runat="server" Visible="false">
                        <div id="login-alert" class="alert alert-danger col-sm-12">Invalid username and/or password.</div>
                            </asp:Literal>
                            
                        <div id="loginform" class="form-horizontal" role="form">
                                    
                            <div style="margin-bottom: 25px" class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                        <asp:TextBox ID="UsernameTextBox" runat="server" class="form-control" value="" autofocus placeholder="username or email"></asp:TextBox>                                      
                                    </div>
                                
                            <div style="margin-bottom: 25px" class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                        <asp:TextBox ID="PasswordTextBox" runat="server" type="password" class="form-control" placeholder="password"></asp:TextBox>
                                    </div>
                                    

                                
                            <div class="input-group">
                                      <div class="checkbox">
                                        <label>
                                            <asp:CheckBox ID="PersistCheckBox" runat="server" />Remember me
                                        </label>                                          
                                      </div>
                                    </div>


                                <div style="margin-top:10px" class="form-group">
                                    <!-- Button -->

                                    <div class="col-sm-12 controls">
                                        <asp:LinkButton ID="LoginButton" runat="server" OnClick="LoginButton_Click" Text="Login" class="btn btn-success" />
                                    </div>
                                </div>


                                <div class="form-group">
                                    <div class="col-md-12 control">
                                        <div style="border-top: 1px solid#888; padding-top:15px; font-size:85%" >
                                            Don't have an account? 
                                        <a href="#" onClick="$('#loginbox').hide(); $('#signupbox').show()">
                                            Sign Up Here
                                        </a>
                                        </div>
                                    </div>
                                </div>    
                            </div>     



                        </div>                     
                    </div>  
        </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" SelectCommand="SELECT [UserName], [UserPassword] FROM [tblUsers] WHERE (([UserName] = ?) AND ([UserPassword] = ?))" ConnectionString="<%$ ConnectionStrings:DFW_ACCDB_Connection %>" ProviderName="<%$ ConnectionStrings:DFW_ACCDB_Connection.ProviderName %>">
            <SelectParameters>
                <asp:ControlParameter ControlID="UsernameTextBox" Name="UserName" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="PasswordTextBox" Name="UserPassword" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>


        <div id="signupbox" style="display:none; margin-top:50px" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <div class="panel-title">Sign Up</div>
                            <div style="float:right; font-size: 80%; position: relative; top:-15px"><a id="signinlink" href="#" onclick="$('#signupbox').hide(); $('#loginbox').show()">Sign In</a></div>
                        </div>  
                        <div class="panel-body" >
                            <div id="signupform" class="form-horizontal" role="form">
                                
                                <div id="signupalert" style="display:none" class="alert alert-danger">
                                    <p>Error:</p>
                                    <span></span>
                                </div>
                                    
                                
                                  
                                <div class="form-group">
                                    <label for="email" class="col-md-3 control-label">Email</label>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" name="email">
                                    </div>
                                </div>
                                    
                                <div class="form-group">
                                    <label for="firstname" class="col-md-3 control-label">First Name</label>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" name="firstname">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="lastname" class="col-md-3 control-label">Last Name</label>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" name="lastname">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="password" class="col-md-3 control-label">Password</label>
                                    <div class="col-md-9">
                                        <input type="password" class="form-control" name="passwd">
                                    </div>
                                </div>
                                    
                                <div class="form-group">
                                    <label for="icode" class="col-md-3 control-label">Invite Code</label>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" name="icode">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <!-- Button -->                                        
                                    <div class="col-md-offset-3 col-md-9">
                                        <button id="btn-signup" type="button" disabled class="btn btn-info"><i class="icon-hand-right"></i>Sign Up</button>
                                    </div>
                                </div>
             
                            </div>
                         </div>
                    </div>

               
               
                
         </div> 
</asp:Content>
