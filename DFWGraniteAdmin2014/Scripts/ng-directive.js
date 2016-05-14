// override the default input to update on blur
angular.module('gabsNgApp', []).directive('ngModelOnblur', function () {
    return {
        restrict: 'A',
        require: 'ngModel',
        link: function (scope, elm, attr, ngModelCtrl) {
            if (attr.type === 'radio') return;

            elm.unbind('input').unbind('keydown').unbind('change');
            elm.bind('blur', function () {
                scope.$apply(function () {
                    ngModelCtrl.$setViewValue(elm.val());
                });
            });
        }
    };
});
â€‹