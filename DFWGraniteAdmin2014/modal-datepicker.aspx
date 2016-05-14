<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="modal-datepicker.aspx.cs" Inherits="DFWGraniteAdmin2014.modal_datepicker" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

<script type='text/javascript' src='//code.jquery.com/jquery-1.9.1.js'></script>
  
  
  
  
  <script type="text/javascript" src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
  <link rel="stylesheet" type="text/css" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css">
  
  <link rel="stylesheet" type="text/css" href="/css/result-light.css">
  
    
      <script type='text/javascript' src="//maxcdn.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
    
  
    
      <link rel="stylesheet" type="text/css" href="//maxcdn.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css">
    
  
    
      <link rel="stylesheet" type="text/css" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
    
  
  <style type='text/css'>
    
  </style>
  


<script type='text/javascript'>//<![CDATA[ 
    $(function () {
        $('#idTourDateDetails').datepicker({
            dateFormat: 'dd-mm-yy',
            minDate: '+5d',
            changeMonth: true,
            changeYear: true,
            altField: "#idTourDateDetailsHidden",
            altFormat: "yy-mm-dd"
        });


        $.fn.modal.Constructor.prototype.enforceFocus = function () { };


    });//]]>  

</script>


</head>
<body>
    <form id="form1" runat="server">
 <!-- Button trigger modal -->
<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">Launch demo modal</button>
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                 <h4 class="modal-title" id="myModalLabel">Modal title</h4>

            </div>
            <div class="modal-body">
                <div class="col-md-12">
                    <div class="row">
                        <label for="idTourDateDetails">Tour Start Date:</label>
                        <div class="form-group">
                            <div class="input-group">
                                <input type="text" name="idTourDateDetails" id="idTourDateDetails" readonly="readonly" class="form-control clsDatePicker"> <span class="input-group-addon"><i id="calIconTourDateDetails" class="glyphicon glyphicon-th"></i></span>

                            </div>
                        </div>Alt Field:
                        <input type="text" name="idTourDateDetailsHidden" id="idTourDateDetailsHidden">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
  </div>
    </form>
</body>
</html>
