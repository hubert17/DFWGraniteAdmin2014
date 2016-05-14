<%@ Page Title="Manage Granite" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="manage-granite.aspx.cs" Inherits="DFWGraniteAdmin2014.admin.manage_granite" %>
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
    <div data-ng-app="gabsNgApp">
        <div data-ng-controller="myController" data-ng-init="loadData();" ng-cloak class="ng-cloak" >
            <div id="mydiv" data-ng-show="loading">
                <img src="/admin2014/Images/ajax_loader.gif" class="ajax-loader" />
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <h2 class="page-header" style="margin-top:5px;">
                        Granite 
                        <span class="pull-right"><a class="btn btn-success" data-toggle="modal" href="#addGraniteModal" data-backdrop="static" data-keyboard="false">Add</a></span>
                    </h2>
                </div>
            </div>
            <div class="row">
   <ng-form id="myForm" name="myForm" >
                <div class="col-sm-4" ng-class="{error: myForm.searchQry.$invalid}">
                    <div class="input-group" style="padding-bottom:15px;">
				        <input type="text" on-keyup="bla" keys="[13]" name="searchQry" placeholder="Search " ng-model="searchQry.SlabColor" ng-change="totalDisplayed=10;" ng-minlength="3" required class="form-control" />
					     <div class="input-group-btn">
				        <a class="btn btn-success" ng-click="totalDisplayed = myModelS.length;" ng-disabled="myForm.searchQry.$error.minlength || myForm.searchQry.$error.required" ><span class="glyphicon glyphicon-search"></span></a>
				        </div>
				    </div>                    
                 </div>

   </ng-form>
                <div class="col-md-2 pull-right text-right">
                    <label title="Search"><input type="checkbox" id="chkShowInactive"  /> Show Discontinued</label>

                </div>

            </div>
            <div data-ng-controller="AlertDemoCtrl">
                <alert ng-repeat="alert in alerts" type="{{alert.type}}" close="closeAlert($index)" class="ng-alert-fadeOut">{{alert.msg}}</alert>
            </div>
            <div class="table-responsive" style="overflow-y:scroll;height: 400px;" when-scrolled="loadMore()">
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th class="hidden">#</th>
                        <th>Stone Name</th>
                        <th class="text-nowrap">Type</th>
                        <th class="text-nowrap">Catalog ID</th>
                        <th class="text-nowrap text-right">2cm Price</th>
                        <th class="text-nowrap text-right">3cm Price</th>
                        <th class="text-nowrap text-right">WO Price</th>
                        <th class="text-nowrap">Image Filename</th>
                        <th class="text-center" title="Discontinued">Disc</th>
                        <th style="width:10%;min-width:20px;">Action</th>
                    </tr>
                    </thead>

                    <tbody>
                    <tr data-ng-repeat="granite in myModelS | limitTo:totalDisplayed | filter:{SlabColor:searchQry.SlabColor} track by granite.GraniteID">

                        <td class="hidden">
                            <strong data-ng-hide="granite.editMode" ng-model="granite.GraniteID"></strong>
                        </td>
                        <td>
                            <span data-ng-hide="granite.editMode">{{ granite.SlabColor }}</span> <span data-ng-hide="granite.editMode"><span ng-if="granite.DaltilePrice3cm > 0">3cm</span><span ng-if="granite.DaltilePrice2cm > 0">2cm</span></span>
                            <span data-ng-show="granite.editMode">
                                <input type="text" data-ng-model="granite.SlabColor" class="form-control" />
                            </span>
                        </td>
                        <td>
                            <span data-ng-hide="granite.editMode">{{ granite.Type | StoneTypeLookup }}</span>
                            <span data-ng-show="granite.editMode">
                                <select ng-model="granite.Type" class="form-control text-nowrap">
                                    <option value="G">Granite</option>
                                    <option value="M">Marble</option>
                                    <option value="L">L</option>
                                    <option value="T">T</option>
                                    <option value="S">S</option>
                                    <option value="NQ">NQ</option>
                                    <option value="WK">WK</option>
                                </select>
                            </span>
                        </td>
                        <td>
                            <span data-ng-hide="granite.editMode">{{ granite.CatalogID}}</span>
                            <input data-ng-show="granite.editMode" type="text" data-ng-model="granite.CatalogID" class="form-control text-right" />
                        </td>
                        <td class="text-right">
                            <span data-ng-hide="granite.editMode || granite.DaltilePrice2cm.length==0">{{ granite.DaltilePrice2cm | number:2 }}</span>
                            <input data-ng-show="granite.editMode" type="text" data-ng-model="granite.DaltilePrice2cm" class="form-control text-right" />
                        </td>
                        <td class="text-right">
                            <span data-ng-hide="granite.editMode || granite.DaltilePrice3cm.length==0">{{ granite.DaltilePrice3cm | number:2 }}</span>
                            <input data-ng-show="granite.editMode" type="text" data-ng-model="granite.DaltilePrice3cm" class="form-control text-right" />
                        </td>
                        <td class="text-right">
                            <span data-ng-hide="granite.editMode || granite.WOPrice.length==0">{{ granite.WOPrice | number:2 }}</span>
                            <input data-ng-show="granite.editMode" type="text" data-ng-model="granite.WOPrice" class="form-control text-right" />
                        </td>
                        <td>
                            <span data-ng-hide="granite.editMode"><input type="text" id="{{ granite.GraniteID }}" data-ng-model="granite.ImageFilename" readonly class="tpInput" /></span>
                            <a class="btn btn-sm btn-info open-uploadImageModal" data-ng-show="granite.editMode" data-toggle="modal" href="#uploadImageModal" data-backdrop="static" data-keyboard="false"  ng-attr-data-id="{{granite.GraniteID}}" ng-attr-title="{{granite.ImageFilename}}">Upload Picture</a>
                        </td>
                        <td class="text-center">
                            <span data-ng-hide="granite.editMode"><input type="checkbox" data-ng-model="granite.Discontinued" disabled ng-true-value='True' ng-false-value='False' /></span>
                            <span data-ng-show="granite.editMode">
                                <input type="checkbox" ng-model="granite.Discontinued" ng-true-value='True' ng-false-value='False' />
                            </span>
                        </td>
                        <td>
                            <span data-ng-hide="granite.editMode"><a data-ng-click="toggleEdit(granite)" href="javascript:;"><span class="glyphicon glyphicon-pencil col-sm-8"></span></a><a data-ng-click="delete(granite)" href="javascript:;"><span class="glyphicon glyphicon-trash hidden"></span></a></span>
                            <span data-ng-show="granite.editMode"><a data-ng-click="save(granite)" href="javascript:;"><span class="glyphicon glyphicon-ok col-sm-8"></span></a> | <a data-ng-click="toggleEdit(granite)" href="javascript:;"><span class="glyphicon glyphicon-remove-sign"></span></a></span>
                        </td>

                    </tr>
                        </tbody>
                </table>
            </div>

<div class="modal fade" id="addGraniteModal" tabindex="-1" role="dialog" aria-labelledby="addGraniteModal" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <ng-form name="addGraniteForm">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Add New Granite</h4>
                        </div>

                        <div class="modal-body">
                            <div class="row">
                                 <div class="form-group col-sm-6" show-errors>
                                  Stone Name<input type="text" name="SlabColor" data-ng-model="newModel.SlabColor" required class="form-control" placeholder="'$' prefixed hidden from customer..." title="Prefix with '$' sign to hide from customer online quote system..." />
                                  <span class="text-danger error" ng-if="addGraniteForm.SlabColor.$error.required">Required</span>
                                </div>
                                 <div class="form-group col-sm-6" show-errors>
                                    Type<select name="Type" ng-model="newModel.Type" required class="form-control text-nowrap">
                                        <option value="G">Granite</option>
                                        <option value="M">Marble</option>
                                        <option value="L">L</option>
                                        <option value="T">T</option>
                                        <option value="S">S</option>
                                        <option value="NQ">NQ</option>
                                        <option value="WK">WK</option>
                                    </select>     
                                     <span class="text-danger error" ng-if="addGraniteForm.Type.$error.required">Required</span>                    
                                </div>
                             </div>
                            <div class="row">
                                <div class="form-group col-xs-6">
                                    Catalog ID<input type="text" name="CatalogID" data-ng-model="newModel.CatalogID" class="form-control" />
                                    <span>&nbsp</span>
                                </div>
                                <div class="form-group col-xs-6">
                                    Work Order Price<input type="text" name="WOPrice" data-ng-model="newModel.WOPrice" class="form-control" />
                                    <span>&nbsp</span>
                                </div>
                             </div>
                            <div class="row">
                                <div class="form-group col-xs-6">
                                    2cm Price<input type="text" name="DaltilePrice2cm" data-ng-model="newModel.DaltilePrice2cm" class="form-control" />
                                </div>
                                <div class="form-group col-xs-6">
                                    3cm Price<input type="text" name="DaltilePrice3cm" data-ng-model="newModel.DaltilePrice3cm" class="form-control" />
                                </div>
                            </div>
                        </div>                        

                        <div class="modal-footer">
                            <a data-dismiss="modal" data-ng-click="reset()" class="btn btn-default">Cancel</a>
                            <a data-ng-click="add()" data-ng-disabled="!addGraniteForm.$valid" class="closeModal btn btn-primary">Submit</a>

                        </div>
                    </ng-form>
                </div>
            </div>

        </div>


            <div class="modal fade" id="uploadImageModal" tabindex="-1" role="dialog" aria-labelledby="uploadImageModal" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Image Uploader</h4>
                        </div>

                        <div class="modal-body">
                           <iframe id="IframeUploader" style="width:100%;" height="400" frameborder="0" seamless></iframe>  
                        </div>                        

                        <div class="modal-footer">
                            <a data-dismiss="modal" class="btn btn-default">Close</a>
                        </div>
                </div>
            </div>

        </div>

                <script type='text/javascript'>
                    closeuploadImageModal = function (slabID, imgFilename) {
                        $('#' + slabID + '').val(imgFilename);
                        $('#uploadImageModal').modal('hide');                        
                    }
                    </script>
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
            $('#IframeUploader').removeAttr("src");
            //alert('modal is now hidden.')
        });

        $(window).load(function () {
            $(document).on("click", ".open-uploadImageModal", function (e) {
                e.preventDefault();

                var _self = $(this);

                var graniteId = _self.data('id');
                $('#IframeUploader').attr('src', 'image-uploader.aspx?SlabColorID=' + graniteId + '&iframe=true');
                //$(_self.attr('href')).modal('show');
            });
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

        if (getParameterByName('showDiscontinued') == 'true')
            $('#chkShowInactive').prop('checked', true);
        else
            $('#chkShowInactive').prop('checked', false);

        $(document).ready(function () {
            $('#chkShowInactive').change(function () {
                if ($(this).is(":checked")) {
                    window.location = 'manage-granite.aspx?showDiscontinued=true'
                }
                else
                    window.location = 'manage-granite.aspx?showDiscontinued=false';
            });
        });
    </script>

    <script>
        var app = angular.module('gabsNgApp', ['ui.bootstrap', 'ngAnimate', 'ui.bootstrap.showErrors']);
        var url = 'http://granitesouthlake.com/WebApiDFW/api/granite/';

        app.factory('myFactory', function ($http) {
            return {
                getModel: function () {
                    if (getParameterByName('showDiscontinued') == 'true')
                        return $http.get(url + '?showDiscontinued=True');
                    return $http.get(url);
                },
                addModel: function (granite) {
                    return $http.post(url, granite);
                },
                deleteModel: function (granite) {
                    return $http.delete(url + granite.GraniteID);
                },
                updateModel: function (granite) {
                    return $http.put(url + granite.GraniteID, granite);
                },

            };
        });

        app.controller('myController', function PostsController($scope, myFactory) {
            $scope.myModelS = [];
            $scope.totalDisplayed = 10;
            $scope.loading = true;
            $scope.addMode = true;
            $scope.searchCount = 0;

            $scope.toggleEdit = function () {
                this.granite.editMode = !this.granite.editMode;
            };
            $scope.toggleAdd = function () {
                $scope.addMode = !$scope.addMode;
            };
            $scope.save = function () {
                $scope.loading = true;
                var thisModel = this.granite;
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
                    var currentModel = this.granite;
                    //alert(currentModel.GraniteID);
                    myFactory.deleteModel(currentModel).success(function (data) {
                        $scope.addAlert('warning', 'Deleted Successfully!', 5000);
                        $.each($scope.myModelS, function (i) {
                            if ($scope.myModelS[i].GraniteID === currentModel.GraniteID) {
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
                myFactory.getModel().success(function (data) {
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

        app.directive('onChange', function() {    
            return {
                restrict: 'A',
                scope:{'onChange':'=' },
                link: function(scope, elm, attrs) {            
                    scope.$watch('onChange', function(nVal) { elm.val(nVal); });            
                    elm.bind('blur', function() {
                        var currentValue = elm.val();                
                        if( scope.onChange !== currentValue ) {
                            scope.$apply(function() {
                                scope.onChange = currentValue;
                            });
                        }
                    });
                }
            };        
        });

        app.directive('onKeyup', function () {
            return function (scope, elm, attrs) {
                var allowedKeys = scope.$eval(attrs.keys);
                elm.bind('keydown', function (evt) {
                    angular.forEach(allowedKeys, function (key) {
                        if (key == evt.which) {
                            evt.preventDefault(); // Doesn't work at all
                            window.stop(); // Works in all browsers but IE    
                            document.execCommand("Stop"); // Works in IE
                            
                            return false; // Don't even know why it's here. Does nothing. 
                        }
                    });
                });
            };
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


        app.filter('StoneTypeLookup', function () {
            return function (val, length, end) {
                switch (val) {
                    case 'G': return 'Granite';
                        break;
                    case 'M': return 'Marble';
                        break;
                }
                return val;
            }
        });



    </script>

</asp:Content>
