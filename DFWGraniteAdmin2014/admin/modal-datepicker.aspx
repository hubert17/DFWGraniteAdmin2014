<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="modal-datepicker.aspx.cs" Inherits="DFWGraniteAdmin2014.admin.modal_datepicker" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style type='text/css'>
.clsDatePicker {
    z-index: 100000;
}
  </style>
  


<script type='text/javascript'>
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


    });

</script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
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
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="postformtag" runat="server">
</asp:Content>
