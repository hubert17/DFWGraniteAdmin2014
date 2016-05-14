<%@ Page Title="Manage Services" Language="C#" MasterPageFile="~/Site.master" EnableViewState="false" AutoEventWireup="true" CodeBehind="manage-services.aspx.cs" Inherits="DFWGraniteAdmin2014.admin.manage_services" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet" />
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.25/angular.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.25/angular-animate.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/0.11.0/ui-bootstrap-tpls.min.js"></script>
    <script src="/admin2014/Scripts/ng-alert-service.js"></script>
    <script src="/admin2014/Scripts/showErrors.min.js"></script>

<style>
        #mydiv {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1000;
        }
        .ajax-loader {
            position: absolute;
            left: 50%;
            top: 200%;
            margin-left: -32px; /* -1 * image width / 2 */
            margin-top: -128px; /* -1 * image height / 2 */
            display: block;
        }

    </style>

    <style>
        .modal-body .form-group {
            margin-bottom: 5px; 
        }
        .form-group .text-danger {
          visibility:hidden;                   
        }
        .form-group.has-error .text-danger {
          visibility:visible; 
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
<div data-ng-app="gabsNgApp">
<div data-ng-controller="myController" data-ng-init="loadData();" ng-cloak class="col-md-10 col-md-offset-1 ng-cloak">
     <div id="mydiv" data-ng-show="loading">
        <img src="/admin2014/Images/ajax_loader.gif" class="ajax-loader" />
    </div>

    <div class="row">
        <div class="col-lg-12">
            <h2 class="page-header" style="margin-top:5px;" >Services
                <span class="pull-right"><a class="btn btn-success" data-toggle="modal" href="#addServicesModal" data-backdrop="static" data-keyboard="false">Add</a></span>
            </h2>
         </div>                   
    </div>
    <div class="row">
        <div class="col-xs-6"><p class="services"></p></div>                         
                            <div class="col-md-2 pull-right text-right">
                               <label ><input type="checkbox" id="chkShowInactive" /> Show Inactive</label>
                         
                </div>

       </div>
    <div data-ng-controller="AlertDemoCtrl">

        <alert ng-repeat="alert in alerts" type="{{alert.type}}" close="closeAlert($index)" class="ng-alert-fadeOut">{{alert.msg}}</alert>

        <div class="modal fade" id="addServicesModal" tabindex="-1" role="dialog" aria-labelledby="addServicesModal" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <ng-form id="test" name="test">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Add New Services</h4>
                        </div>

                        <div class="modal-body">
                            <div class="row">
                                 <div class="form-group col-md-12" show-errors>
                                  Service Name<input type="text" name="ServiceName" data-ng-model="newModel.ServiceName" required class="form-control" />
                                  <span class="text-danger error" ng-show="test.ServiceName.$error.required">Required</span>
                                </div>
                                 <div class="form-group col-xs-6" show-errors>
                                    Service Price<input type="text" name="ServicePrice" data-ng-model="newModel.ServicePrice" required class="form-control" />
                                    <span class="text-danger error" ng-show="test.ServicePrice.$error.required">Required</span>                           
                                </div>
                                <div class="col-xs-6 form-group"  show-errors>
                                    WO Price<input type="text" name="WOPrice" data-ng-model="newModel.WOPrice" required class="form-control" />
                                        <span class="text-danger error" ng-show="test.WOPrice.$error.required">Required</span>                            
                                </div>
                            <div class="col-xs-6">
                            View
                                <select name="AdminOnly" data-ng-model="newModel.AdminOnly" ng-true-value='True' ng-false-value='False' class="form-control">
                                    <option value="True">Admin</option>
                                    <option value="False">All</option>
                                </select>
                            
                                </div>
                            <div class="col-xs-6">Quantity Mode
                               <label class="form-control"><input type="checkbox" name="ServiceType" data-ng-model="newModel.ServiceType" /> {{newModel.ServiceType | boolQtyMode}}</label>
                            
                                </div>

                            </div>
                        </div>                        

                        <div class="modal-footer">
                            <a data-dismiss="modal" data-ng-click="reset()" class="btn btn-default">Cancel</a>
                            <a data-ng-click="add()" data-ng-disabled="!test.$valid" class="closeModal btn btn-primary">Submit</a>

                        </div>
                    </ng-form>
                </div>
            </div>

        </div>
    </div>
    <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <tr>
                                        <th class="hidden">#</th>
                                        <th>Service Name</th>
                                        <th class="text-right">Price</th>
                                        <th class="text-right">WO Price</th>
                                        <th class="text-center text-nowrap">Qty Mode</th>                                        
                                        <th>View</th>
                                        <th class="text-center">Inactive</th>
                                        <th style="width:10%;min-width:20px;">Action</th>
                                    </tr>

                                    <tr data-ng-repeat="services in myModelS" >
                                        
                                        <td class="hidden">
                                            <strong data-ng-hide="services.editMode">{{ services.ServicesID }}</strong>
                                        </td>
                                        <td>
                                            <span data-ng-hide="services.editMode">{{ services.ServiceName }}</span>
                                            <span data-ng-show="services.editMode">
                                                <input type="text" data-ng-model="services.ServiceName" class="form-control"/>
                                            </span>
                                        </td>
                                        <td class="text-right">
                                            <span data-ng-hide="services.editMode">{{ services.ServicePrice | number:2}}</span>
                                            <input data-ng-show="services.editMode" type="text" data-ng-model="services.ServicePrice" class="form-control text-right"/>
                                        </td>
                                      <td class="text-right">
                                            <span data-ng-hide="services.editMode">{{ services.WOPrice | number:2}}</span>
                                            <input data-ng-show="services.editMode" type="text" data-ng-model="services.WOPrice" class="form-control text-right"/>
                                        </td>
                                        <td class="text-center">
                                            <span data-ng-hide="services.editMode"><input type="checkbox" data-ng-model="services.ServiceType" disabled  ng-true-value='D' /></span>
                                            <span data-ng-show="services.editMode && services.ServiceType != 'TOC'">
                                                <input type="checkbox" ng-model="services.ServiceType"  ng-true-value='D'/>
                                            </span>
                                        </td>
                                      <td>
                                            <span data-ng-hide="services.editMode">{{services.AdminOnly | boolAdmin}}</span>
                                             <span data-ng-show="services.editMode">
                                                     <select ng-model="services.AdminOnly" ng-true-value='True' ng-false-value='False' class="form-control text-right">
                                                      <option value="True">Admin</option>
                                                      <option value="False">All</option>
                                                    </select>
                                            </span>
                                        </td>
                                        <td class="text-center">
                                            <span data-ng-hide="services.editMode"><input type="checkbox" data-ng-model="services.Inactive" disabled  ng-true-value='True' ng-false-value='False'/></span>
                                            <span data-ng-show="services.editMode">
                                                <input type="checkbox" ng-model="services.Inactive"  ng-true-value='True' ng-false-value='False' />
                                            </span>
                                        </td>
                                        <td>
                                            <span data-ng-hide="services.editMode"><a data-ng-click="toggleEdit(services)" href="javascript:;"><span class="glyphicon glyphicon-pencil col-sm-8"></span></a><a data-ng-click="delete(services)" href="javascript:;"><span class="glyphicon glyphicon-trash hidden"></span></a></span>
                                            <span data-ng-show="services.editMode"><a data-ng-click="save(services)" href="javascript:;"><span class="glyphicon glyphicon-ok col-sm-8"></span></a> | <a data-ng-click="toggleEdit(services)" href="javascript:;"><span class="glyphicon glyphicon-remove-sign"></span></a></span>
                                        </td>
                                          
                                    </tr>
                                </table>
                            </div>

</div>
</div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="postformtag" runat="server">
    <script type='text/javascript'>
        $(window).load(function () {
            $('.panel').on('show.bs.collapse', function (e) {
                $('.' + e.currentTarget.id + 'btnAdd').fadeIn('slow');
            })
            $('.panel').on('hide.bs.collapse', function (e) {
                $('.' + e.currentTarget.id + 'btnAdd').hide('slow');
            })
        });

        $('.closeModal').click(function () {
            $('.modal').modal('hide');
        });

        $('.modal').on('hidden.bs.modal', function () {
            $(this).removeData('bs.modal');
            //alert('modal is now hidden.')
        });
    </script>

    <script type="text/javascript">
        $('.modal').on('show.bs.modal', function () {
            var modal = this;
            var hash = modal.id;
            window.location.hash = hash;
            window.onhashchange = function () {
                if (!location.hash) {
                    $(modal).modal('hide');
                }
            }
        });

        $('.modal').on('hide', function () {
            var hash = this.id;
            history.pushState('', document.title, window.location.pathname);
        });
    </script>

    <script>
        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                results = regex.exec(location.search);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));

            
        }

        if (getParameterByName('showInactive') == 'true')
            $('#chkShowInactive').prop('checked', true);
        else
            $('#chkShowInactive').prop('checked', false);

        $(document).ready(function () {
            $('#chkShowInactive').change(function () {
                if ($(this).is(":checked")) {
                    window.location = 'manage-services.aspx?showInactive=true'
                }
                else
                    window.location = 'manage-services.aspx?showInactive=false';
            });
        });
    </script>

    <script>
        var app = angular.module('gabsNgApp', ['ui.bootstrap', 'ngAnimate', 'ui.bootstrap.showErrors']);
        var url = 'http://granitesouthlake.com/WebApiDFW/api/services/';

        app.factory('myFactory', function ($http) {
            return {
                getModel: function () {
                    if (getParameterByName('showInactive')=='true')
                        return $http.get(url + '?showInactive=True'); 
                    return $http.get(url);
                },
                addModel: function (services) {
                    return $http.post(url, services);
                },
                deleteModel: function (services) {
                    return $http.delete(url + services.ServicesID);
                },
                updateModel: function (services) {
                    return $http.put(url + services.ServicesID, services);
                },

            };
        });

        app.controller('myController', function PostsController($scope, myFactory) {
            $scope.myModelS = [];
            $scope.loading = true;
            $scope.addMode = true;

            $scope.toggleEdit = function () {
                this.services.editMode = !this.services.editMode;
            };
            $scope.toggleAdd = function () {
                $scope.addMode = !$scope.addMode;
            };
            $scope.save = function () {
                $scope.loading = true;
                var thisModel = this.services;
                myFactory.updateModel(thisModel).success(function (data) {
                    $scope.addAlert('success', 'Saved Successfully!', 5000);
                    thisModel.editMode = false;
                    $scope.loading = false;
                }).error(function (data) {
                    $scope.addAlert('danger', 'An Error has occured while Saving data! ' + data.ExceptionMessage);
                    $scope.loading = false;
                });
            };

            // add Data
            $scope.add = function () {
                $scope.loading = true;
                myFactory.addModel(this.newModel).success(function (data) {
                    $scope.addAlert('success', 'Added Successfully!', 5000);
                    $scope.myModelS.push(data);
                    $scope.loading = false;
                    $scope.newModel = null;
                }).error(function (data) {
                    $scope.addAlert('danger', 'An Error has occured while Adding data! ' + data.ExceptionMessage);
                    $scope.loading = false;
                });
                this.newModel = null;
            };

            // delete Data
            $scope.delete = function () {
                var result = confirm("Are you sure?");
                if (result == true) {
                    $scope.loading = true;
                    var currentModel = this.services;
                    //alert(currentModel.ServicesID);
                    myFactory.deleteModel(currentModel).success(function (data) {
                        $scope.addAlert('warning', 'Deleted Successfully!', 5000);
                        $.each($scope.myModelS, function (i) {
                            if ($scope.myModelS[i].ServicesID === currentModel.ServicesID) {
                                $scope.myModelS.splice(i, 1);
                                return false;
                            }
                        });
                        $scope.loading = false;
                    }).error(function (data) {
                        $scope.addAlert('danger', 'An Error has occured while Saving data! ' + data.ExceptionMessage);
                        $scope.loading = false;
                    });
                }
            };

            //get all Data
            $scope.loadData = function (showInactive) {
                myFactory.getModel().success(function (data) {
                    $scope.myModelS = data;
                    $scope.loading = false;
                })
                .error(function (data) {
                    $scope.addAlert('danger', 'An Error has occured while Loading data! ' + data.ExceptionMessage);
                    $scope.loading = false;
                });
            };

            $scope.reset = function () {
                $scope.$broadcast('show-errors-reset');
                $scope.newModel = null;
            }

        });


        app.filter('boolAdmin', function () {
            return function (val, length, end) {
                if (val=='False') {
                    return 'All';
                }
                return 'Admin';
            }
        });

        app.filter('boolQtyMode', function () {
            return function (val, length, end) {
                if (val == true) {
                    return 'enable Discount input';
                }
                return 'fixed amount';
            }
        });

    </script>

</asp:Content>
