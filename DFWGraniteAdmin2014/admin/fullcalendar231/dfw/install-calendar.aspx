<%@ Page Title="DFW Install Calendar" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="install-calendar.aspx.cs" Inherits="DFWGraniteAdmin2014.admin.install_calendar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
    /* Responsive iFrame */

    .responsive-iframe-container {
        position: relative;
        padding-bottom: 50%;
        padding-top: 30px;
        height: 0;
        overflow: hidden;
    }

    .responsive-iframe-container iframe,
    .vresponsive-iframe-container object,
    .vresponsive-iframe-container embed {
        position: absolute;
        top: 0;
        left: 0;
        width: 100% !important;
        height: 90% !important;
    }

    @media (max-width: 768px) {
        .responsive-iframe-container {
           overflow:scroll;
           height: 440px;
           padding-bottom: 0%; !important;
        }

        .responsive-iframe-container iframe,
        .vresponsive-iframe-container object,
        .vresponsive-iframe-container embed {
            width: 800px !important;
            height:400px !important;
        }
    }
     /*Full Calendar.io css*/
    	#loading {
		display: none;
		position: absolute;
		top: 10px;
		right: 10px;
	}

	#calendar {
		max-width: 1024px;
		margin: 20px auto;
		padding: 0 5px 100px;
	}

     #preview {
        position:absolute;
        padding: 10px;
        max-width: 400px;
        z-index:10000;
        border:1px solid #ccc;
        background:#333;
        padding:5px;
        display:none;
        color: #7FD2FF;
    }
    #preview th, td{
        border-bottom: 1px solid gray;
        vertical-align:top;
        padding-left: 5px;
        padding-right: 5px;
    } 
    #preview td span {
        color:#fff;        
    }  
    #preview th{
        font-size: large; 
        background-color: #428bca;  
        color:#fff;  
        border-bottom: none;    
    } 

</style>

<link href='../fullcalendar.css' rel='stylesheet' />
<link href='../fullcalendar.print.css' rel='stylesheet' media='print' />

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
<!-- Responsive iFrame -->
<div class="responsive-iframe-container" style="display:none;">
    <iframe src="https://www.google.com/calendar/embed?src=60ngsfs8erai9mep5blrh49skc%40group.calendar.google.com&ctz=America/Chicago" style="border: 0" frameborder="0" scrolling="no"></iframe>
</div>

	<div id='loading'>loading...</div>
	<div id='calendar'></div>



</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="postformtag" runat="server">
    <script src='../lib/moment.min.js'></script>
    <script src='../fullcalendar.min.js'></script>
    <script src='../lib/jquery.balloon.min.js'></script>

    <script>        
        $(document).ready(function () {

            $('#calendar').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay'
                },
                aspectRatio: 2.3,
                defaultDate: '<%= DateTime.Now.ToString("yyyy-MM-dd") %>',
                fixedWeekCount: false,
                timezone: 'America/Texas',
                editable: true,
                eventLimit: true, // allow "more" link when too many events
                //events: {
                //    url: 'http://www.granitesouthlake.com/admin2014/admin/DfwCalendarEvents.ashx',
                //    //dataType: 'jsonp',
                //    //crossDomain: true,
                //    error: function () {
                //        $('#script-warning').show();
                //    }
                //},
                eventSources: [
                    {
                        url: "http://www.granitesouthlake.com/admin2014/admin/DfwCalendarEvents.ashx",
                        crossDomain: true
                    }
                ],
                loading: function (bool) {
                    $('#loading').toggle(bool);
                },
                eventClick: function (event, jsEvent, view) {
                    $("body").append("<div id='preview'><table>"
                        + "<tr><th colspan=\"2\">" + event.title + " #" + event.id + "</th></tr>"
                        + "<tr><td>When:</td><td><span>" + event.intallsched + "</span></td></tr>"
                        + "<tr><td>Where:</td><td><span>" + event.location + "</span></td></tr>"
                        + "<tr><td>Edge:</td><td><span>" + event.edge + "</span></td></tr>"
                        + "<tr><td>Slabs:</td><td><span>" + event.slabs + "</span></td></tr>"
                        + "<tr><td>Sinks:</td><td><span>" + event.sinks + "</span></td></tr>"
                        + "<tr><td>Notes:</td><td><span>" + event.notes + "</span></td></tr>"
                        + "</table></div>");

                    $("#preview").css("top", (jsEvent.pageY - xOffset) + "px").css("left", (jsEvent.pageX + yOffset) + "px").fadeIn("fast");
                },
                eventMouseout: function( event, jsEvent, view ) {
                    $("#preview").remove();
                }
            });



        });



    </script>

    <script type="text/javascript">
        /*
         * Image preview script
         * powered by jQuery (http://www.jquery.com)
         *
         * written by Alen Grakalic (http://cssglobe.com)
         *
         * for more info visit http://cssglobe.com/post/1695/easiest-tooltip-and-image-preview-using-jquery
         *
         */

        this.imagePreview = function () { /* CONFIG */

            xOffset = 10;
            yOffset = 30;

            // these 2 variable determine popup's distance from the cursor
            // you might want to adjust to get the right result
            /* END CONFIG */
            $(".fc-day-grid-event").hover(function (e) {
            }, function () {
                $("#preview").remove();
            });
            $(".fc-day-grid-event").mousemove(function (e) {
                $("#preview").css("top", (e.pageY - xOffset) + "px").css("left", (e.pageX + yOffset) + "px");
            });
        };


        // starting the script on page load
        $(document).ready(function () {
            imagePreview();
        });
    </script>
        
</asp:Content>
