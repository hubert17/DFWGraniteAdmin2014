angular.module('gabsNgApp', ['ui.bootstrap']);
var ModalDemoCtrl = function ($scope, $modal, $log) {

    
    $scope.openModal = function (templateid) {

        var modalInstance = $modal.open({
            templateUrl: templateid,
            controller: ModalInstanceCtrl,
            resolve: {
                items: function () {
                    return $scope.items;
                }
            },
            backdrop: 'static',
            // The linking function will add behavior to the template
            link: function(scope, element, attrs) {
                scope.hi = function() { alert("hi"); }
            }
            //END The linking function
        });
    };
};

var ModalInstanceCtrl = function ($scope, $modalInstance, items) {
    $scope.okModal = function () {
        $modalInstance.close();
    };

    $scope.cancelModal = function () {
        $modalInstance.dismiss('cancel');
    };
};

