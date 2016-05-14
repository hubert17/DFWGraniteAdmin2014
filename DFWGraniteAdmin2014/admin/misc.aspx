<%@ Page Title="Miscellaneous" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="misc.aspx.cs" Inherits="DFWGraniteAdmin2014.admin.misc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- FONTAWESOME STYLE CSS -->
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet" />
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.25/angular.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.25/angular-animate.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/0.11.0/ui-bootstrap-tpls.min.js"></script>
    <script src="/admin2014/Scripts/ng-alert-service.js"></script>
    <script src="/admin2014/Scripts/showErrors.min.js"></script>
    
    <!-- CUSTOM STYLE CSS -->
    <style>
        .pad-top {
            padding-top: 10px;
        }

        .panel-title-adjust {
            font-size: 16px;
            padding: 5px;
        }

            .panel-title-adjust a:hover {
                text-decoration: none;
            }

            .panel-title-adjust i {
                padding-right: 5px;
            }

        .col-xs-2, .col-xs-10 {
            display: inline-block;
            float: none;
        }

        .col-xs-10 {
            vertical-align: middle;
        }
    </style>

     <style>
        .divLoading {
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
            top: 70%;
            margin-left: -32px; /* -1 * image width / 2 */
            margin-top: -128px; /* -1 * image height / 2 */
            display: block;
            z-index: 1100;
        }

        .tpInput {
            background-color: rgba(0,0,0,0);
            border: 0px solid rgba(0,0,0,0);
        }

        .tpInput:hover {
            background-color: rgba(0,0,0,0);
            border: 0px solid rgba(0,0,0,0.1);
            border-bottom-width: 1px;
        }

        .tpInput:focus {
            background-color: rgba(0,0,0,0);
            border: 0px solid rgba(0,0,0,0.3);
            border-width: 1px;
        }

        .modal-body {
            max-height: 800px;
            overflow:hidden;
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
    <div class="row">
        <div class="col-lg-12">
            <h2 class="page-header" style="margin-top:5px;">Miscellaneous Setup
         <span class="pull-right text-right">
            <label style="font-size:small;vertical-align:bottom;padding-bottom:0px;color:lightgrey;"><input type="checkbox" id="chkShowInactive"  /> Show Inactive</label>
        </span></h2>
        </div>
    </div>

    <div class="row  pad-top">
        <div class="col-md-12" data-ng-app="gabsNgApp">

            <div class="panel-group" id="accordion" data-ng-controller="AlertDemoCtrl">
                <div id="panelThree" class="panel panel-danger" data-ng-controller="measureController" data-ng-init="loadData();">
                    <div class="panel-heading">
                        <div class="col-xs-10">
                            <h4 class="panel-title panel-title-adjust">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree" class="collapsed">
                                    <i class="fa fa-plus"></i>Measurement Assets
                                </a>
                            </h4>
                        </div>
                        <div class="col-xs-2 pull-right">
                            <span class="pull-right"><button runat="server" class="btnShowModal btn btn-sm btn-danger panelThreebtnAdd" data-toggle="modal" href="#addMeasureAssetModal" data-backdrop="static" data-keyboard="false">Add</button></span>
                        </div>
                    </div>
                    <div id="collapseThree" class="panel-collapse collapse" style="height: 0px;">
                        <div class="divLoading" data-ng-show="loading">
                            <img src="/admin2014/Images/ajax_loader.gif" class="ajax-loader" />
                        </div>
                        <div class="panel-body">            
                            <alert ng-repeat="alert in alerts" type="{{alert.type}}" close="closeAlert($index)" class="ng-alert-fadeOut">{{alert.msg}}</alert>          
                            <div class="table-responsive col-sm-6" style="overflow-y:scroll;height: 400px;" when-scrolled="loadMore()">
                                            <table class="table table-striped table-hover">
                                                <thead>
                                                <tr>
                                                    <th class="hidden">#</th>
                                                    <th>Asset Name</th>
                                                    <th class="text-center">Inactive</th>
                                                    <th style="width:20%;min-width:20px;">Action</th>
                                                    <th style="width:30%;"></th>
                                                </tr>
                                                </thead>

                                                <tbody>
                                                <tr data-ng-repeat="measureAsset in myModelS | limitTo:totalDisplayed ">

                                                    <td class="hidden">
                                                        <strong data-ng-hide="measureAsset.editMode" ng-model="measureAsset.MeasureAssetID"></strong>
                                                    </td>
                                                    <td>
                                                        <span data-ng-hide="measureAsset.editMode">{{ measureAsset.AssetName }}</span>
                                                        <span data-ng-show="measureAsset.editMode">
                                                            <input type="text" data-ng-model="measureAsset.AssetName" class="form-control" />
                                                        </span>
                                                    </td>
                                                    <td class="text-center">
                                                        <span data-ng-hide="measureAsset.editMode"><input type="checkbox" data-ng-model="measureAsset.Inactive" disabled ng-true-value='True' ng-false-value='False' /></span>
                                                        <span data-ng-show="measureAsset.editMode">
                                                            <input type="checkbox" ng-model="measureAsset.Inactive" ng-true-value='True' ng-false-value='False' />
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <span data-ng-hide="measureAsset.editMode"><a data-ng-click="toggleEdit(measureAsset)" href="javascript:;"><span class="glyphicon glyphicon-pencil col-sm-8"></span></a><a data-ng-click="delete(measureAsset)" href="javascript:;"><span class="glyphicon glyphicon-trash hidden"></span></a></span>
                                                        <span data-ng-show="measureAsset.editMode"><a data-ng-click="save(measureAsset)" href="javascript:;"><span class="glyphicon glyphicon-ok col-sm-8"></span></a> | <a data-ng-click="toggleEdit(measureAsset)" href="javascript:;"><span class="glyphicon glyphicon-remove-sign"></span></a></span>
                                                    </td>
                                                    <td></td>
                                                </tr>
                                                    </tbody>
                                            </table>
                                        </div>
                            <div class="modal fade" id="addMeasureAssetModal" tabindex="-1" role="dialog" aria-labelledby="addMeasureAssetModal" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <ng-form name="addMeasureAssetForm">
                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                        <h4 class="modal-title">Add New Measure Asset</h4>
                                                    </div>

                                                    <div class="modal-body">
                                                        <div class="row">
                                                             <div class="form-group col-sm-8 col-sm-offset-2" show-errors>
                                                              Asset Name<input type="text" name="AssetName" data-ng-model="newModel.AssetName" required class="form-control" />
                                                              <span class="text-danger error" ng-if="addMeasureAssetForm.AssetName.$error.required">Required</span>
                                                            </div>
                                                         </div>
                                                    </div>                        

                                                    <div class="modal-footer">
                                                        <a data-dismiss="modal" data-ng-click="reset()" class="btn btn-default">Cancel</a>
                                                        <a data-ng-click="add()" data-ng-disabled="!addMeasureAssetForm.$valid" class="closeModal btn btn-primary">Submit</a>

                                                    </div>
                                                </ng-form>
                                            </div>
                                        </div>

                                    </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="postformtag" runat="server">
    <script type='text/javascript'>
        $('.btnShowModal').hide();
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

        <script>
            function getParameterByName(name) {
                name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
                var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                    results = regex.exec(location.search);
                return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
            }

            if (getParameterByName('showDiscontinued') == 'true')
                $('#chkShowInactive').prop('checked', true);
            else
                $('#chkShowInactive').prop('checked', false);

            $(document).ready(function () {
                $('#chkShowInactive').change(function () {
                    if ($(this).is(":checked")) {
                        window.location = 'misc.aspx?showDiscontinued=true'
                    }
                    else
                        window.location = 'misc.aspx?showDiscontinued=false';
                });
            });
    </script>


    <script>
        var app = angular.module('gabsNgApp', ['ui.bootstrap', 'ngAnimate', 'ui.bootstrap.showErrors']);
        var url = 'http://granitesouthlake.com/WebApiDFW/api/';

        app.factory('measureFactory', function ($http) {
            url += 'measureasset/';
            return {
                getModel: function () {
                    if (getParameterByName('showDiscontinued') == 'true')
                        return $http.get(url + '?showDiscontinued=True');
                    return $http.get(url);
                },
                addModel: function (measureAsset) {
                    return $http.post(url, measureAsset);
                },
                deleteModel: function (measureAsset) {
                    return $http.delete(url + measureAsset.MeasureAssetID);
                },
                updateModel: function (measureAsset) {
                    return $http.put(url + measureAsset.MeasureAssetID, measureAsset);
                },

            };
        });

        app.controller('measureController', function PostsController($scope, measureFactory) {
            $scope.myModelS = [];
            $scope.totalDisplayed = 10;
            $scope.loading = true;
            $scope.addMode = true;

            $scope.toggleEdit = function () {
                this.measureAsset.editMode = !this.measureAsset.editMode;
            };
            $scope.toggleAdd = function () {
                $scope.addMode = !$scope.addMode;
            };
            $scope.save = function () {
                $scope.loading = true;
                var thisModel = this.measureAsset;
                measureFactory.updateModel(thisModel).success(function (data) {
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
                measureFactory.addModel(this.newModel).success(function (data) {
                    $scope.addAlert('success', 'Added Successfully!', 5000);
                    $scope.myModelS.push(data);
                    $scope.loading = false;
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
                    var currentModel = this.measureAsset;
                    //alert(currentModel. MeasureAssetID);
                    measureFactory.deleteModel(currentModel).success(function (data) {
                        $scope.addAlert('warning', 'Deleted Successfully!', 5000);
                        $.each($scope.myModelS, function (i) {
                            if ($scope.myModelS[i]. MeasureAssetID === currentModel. MeasureAssetID) {
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
            $scope.loadData = function () {
                measureFactory.getModel().success(function (data) {
                    $scope.myModelS = data;
                    $scope.loading = false;
                    $scope.newModel = null;
                })
                .error(function (data) {
                    $scope.addAlert('danger', 'An Error has occured while Loading data! ' + data.ExceptionMessage);
                    $scope.loading = false;
                });
            };

            $scope.loadMore = function () {
                $scope.totalDisplayed += 10;
            };

            $scope.reset = function () {
                $scope.$broadcast('show-errors-reset');
                $scope.newModel = null;
            }

        });

        app.factory('leadFactory', function ($http) {
            url += 'lead/';
            return {
                getModel: function () {
                    if (getParameterByName('showDiscontinued') == 'true')
                        return $http.get(url + '?showDiscontinued=True');
                    return $http.get(url);
                },
                addModel: function (lead) {
                    return $http.post(url, lead);
                },
                deleteModel: function (lead) {
                    return $http.delete(url + lead.LeadID);
                },
                updateModel: function (lead) {
                    return $http.put(url + lead.LeadID, lead);
                },

            };
        });

        app.controller('leadController', function PostsController($scope, leadFactory) {
            $scope.myModelS = [];
            $scope.totalDisplayed = 10;
            $scope.loading = true;
            $scope.addMode = true;

            $scope.toggleEdit = function () {
                this.lead.editMode = !this.lead.editMode;
            };
            $scope.toggleAdd = function () {
                $scope.addMode = !$scope.addMode;
            };
            $scope.save = function () {
                $scope.loading = true;
                var thisModel = this.lead;
                leadFactory.updateModel(thisModel).success(function (data) {
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
                leadFactory.addModel(this.newModel).success(function (data) {
                    $scope.addAlert('success', 'Added Successfully!', 5000);
                    $scope.myModelS.push(data);
                    $scope.loading = false;
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
                    var currentModel = this.lead;
                    //alert(currentModel. LeadID);
                    leadFactory.deleteModel(currentModel).success(function (data) {
                        $scope.addAlert('warning', 'Deleted Successfully!', 5000);
                        $.each($scope.myModelS, function (i) {
                            if ($scope.myModelS[i].LeadID === currentModel.LeadID) {
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
            $scope.loadData = function () {
                leadFactory.getModel().success(function (data) {
                    $scope.myModelS = data;
                    $scope.loading = false;
                    $scope.newModel = null;
                })
                .error(function (data) {
                    $scope.addAlert('danger', 'An Error has occured while Loading data! ' + data.ExceptionMessage);
                    $scope.loading = false;
                });
            };

            $scope.loadMore = function () {
                $scope.totalDisplayed += 10;
            };

            $scope.reset = function () {
                $scope.$broadcast('show-errors-reset');
                $scope.newModel = null;
            }

        });

        app.directive('whenScrolled', function () {
            return function (scope, elm, attr) {
                var raw = elm[0];

                elm.bind('scroll', function () {
                    if (raw.scrollTop + raw.offsetHeight >= raw.scrollHeight) {
                        scope.$apply(attr.whenScrolled);
                    }
                });
            };
        });

    </script>


</asp:Content>
