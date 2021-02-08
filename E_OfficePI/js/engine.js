function Msgbox(Msg) {
    $("#Divalert").html(Msg);
    $("#Divalert").alert();
    $("#Divalert").fadeTo(2000, 500).slideUp(500, function () {
        $("#Divalert").slideUp(500);
    });

}
function Msgboxsuccess(Msg)
{
    $("#Divsuccess").html(Msg);
    $("#Divsuccess").alert();
    $("#Divsuccess").fadeTo(2000, 500).slideUp(500, function () {
        $("#Divsuccess").slideUp(500);
    });

}
function OnlyNumeric(event, ctrl) {

    if (event.which != 46 && event.which != 44 && event.which != 8 && event.which != 0 && (event.which < 48 || event.which > 57)) {
        event.preventDefault();
    }
}
function ReplaceNumberWithCommas(yourNumber) {

    if (yourNumber.toString().indexOf('.') > 0) //found comma
    {
        var n = yourNumber.toString().split(".");
        n[0] = n[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return n[0] + '.' + n[1];

    }
    else {

        if (yourNumber.toString() == 'NaN') {

            return "";
        }
        else {
            return yourNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '.' + '00';
        }
    }


}
function Format(ctrl) {
    $(ctrl).val(ReplaceNumberWithCommas($(ctrl).val()));
}
function FormatWithRound(ctrl, Digit) {
    //return $(ctrl).val(ReplaceNumberWithCommas(parseFloat($(ctrl).val())));
    return $(ctrl).val(ReplaceNumberWithCommas(parseFloat($(ctrl).val()).toFixed(Digit)));

}
function FormatWithRound2Digit(Num) {
    return ReplaceNumberWithCommas(parseFloat(Num).toFixed(2));
}
function FormatNumber(val) {

    return ReplaceNumberWithCommas(val);
    //return ReplaceNumberWithCommas(parseFloat(val));
}
function UnFormat(ctrl) {
    $(ctrl).val($(ctrl).val().replace(/,/g, ''));

}
function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}
function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;

    return true;
}
function Unloading() {
    $('#pleaseWaitDialog').modal('hide');
}
function Loading() {
    //if (document.querySelector("#pleaseWaitDialog") == null) {
    //    var modalLoading = '<div class="modal" id="pleaseWaitDialog" data-backdrop="static" data-keyboard="false" role="dialog" style="z-index: 10000000 !important;border-radius:8px important;">\
    //        <div class="modal-dialog">\
    //            <div class="modal-content">\
    //                <div class="modal-body" style="padding:50px;">\
    //                    <div class="progress">\
    //                      <div class="progress-bar progress-bar-info progress-bar-striped active" role="progressbar"\
    //                      aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width:100%; height: 120px">\
    //                      </div>\
    //                    </div>\
    //                </div>\
    //            </div>\
    //        </div>\
    //      </div>';
    //    $(document.body).append(modalLoading);
    //}

    //$("#pleaseWaitDialog").modal("show");
}

function Getparamvalue(param) {
    var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for (var i = 0; i < url.length; i++) {
        var urlparam = url[i].split('=');
        if (urlparam[0] == param) {
            return urlparam[1];
        }
    }
}