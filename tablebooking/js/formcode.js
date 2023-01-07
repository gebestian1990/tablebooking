$(document).ready(function () {

    $(".datepicker").datepicker({
        prevText: '<i class="fa fa-fw fa-angle-left"></i>',
        nextText: '<i class="fa fa-fw fa-angle-right"></i>',
        dateFormat: 'dd/mm/yy',
        minDate: 0,
        todayHighlight: true
    });

    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
    var yyyy = today.getFullYear();

    today = dd + '/' + mm + '/' + yyyy;
    $("#hfdate").val(today);
    $("#hfcdate").val(today);

    var ndate = new Date();
    var hours = ndate.getHours();
    var minutes = ndate.getMinutes();
    var time = hours + ":" + minutes;
    $("#hftime").val(hours + ":" + minutes);
    today = today + ' ' + time;

});
function fnslots() {

    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
    var yyyy = today.getFullYear();

    today = dd + '/' + mm + '/' + yyyy;
    $("#lblbookingdetails").html(today);
    var odate = $("#hfdate").val();
    var cdate = $("#hfcdate").val();

    var ndate = new Date();
    var hours = ndate.getHours();
    var minutes = ndate.getMinutes();
    var time = hours + ":" + minutes;
    $("#hftime").val(hours + ":" + minutes);
    today = today + ' ' + time;
    var type = 0;
    if (odate == cdate) {
        type = 1;
    }
    else {
        type = 2;
    }
    $.ajax({

        type: "POST",
        url: "index.aspx/gettime",
        data: '{time: "' + time + '",type:"' + type + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnSuccessCall,
        error: OnErrorCall

    });
    function OnSuccessCall(response) {

        $("#lblslots").html(response.d)

    }

    function OnErrorCall(response) {

        alert(response.status + " " + response.statusText);

    }
}
function fetchtime() {
    var today = new Date();
    var hours = today.getHours();
    var minutes = today.getMinutes();
    $("#hftime").val(hours + ":" + minutes);
}

setInterval(fetchtime, 10000);
$(function () {
    $(".datepicker").datepicker();
    $(".datepicker").on("change", function () {
        var selected = $(this).val();
        $("#lblbookingdetails").html(selected);
        var today = new Date();
        var hours = today.getHours();
        var minutes = today.getMinutes();
        today = hours + ':' + minutes;
        var odate = $("#hfcdate").val();
        var type = 0;
        if (selected == odate) {
            type = 1;
        }
        else {
            type = 2;
        }
        $.ajax({

            type: "POST",
            url: "index.aspx/gettime",
            data: '{time: "' + today + '",type:"' + type + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnSuccessCall,
            error: OnErrorCall

        });
        function OnSuccessCall(response) {

            $("#lblslots").html(response.d)

        }

        function OnErrorCall(response) {

            alert(response.status + " " + response.statusText);

        }

        $('#hfdate').val(selected);
        $("#lbltimings").html("");
    });
});

function fntimeslots(slots) {
    var type = 0;
    $("#hfslots").val(slots);
    var odate = $("#hfcdate").val();
    var cdate = $("#hfdate").val();
    var time = $("#hftime").val();
    if (cdate == odate) {
        type = 1;
    }
    else {
        type = 2;
    }
    $.ajax({

        type: "POST",
        url: "index.aspx/gettimings",
        data: '{slots: "' + slots + '",time:"' + time + '",type:"' + type + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnSuccessCall,
        error: OnErrorCall

    });
    function OnSuccessCall(response) {

        $("#lbltimings").html(response.d)

    }

    function OnErrorCall(response) {

        alert(response.status + " " + response.statusText);

    }
}
function fngetdata(timings) {
    var timing = $("#rdbtiming" + timings + "").val();
    var etime = timing;
    $("#hfbtime").val(timing);
    $("#hftime").val(timing);
    var label = $("#lblbookingdetails").html();
    label = label + " at " + timing;
    $("#lblbookingdetails").html(label);
    var slots = $("#hfslots").val();
    var nper = $("#qty1").val();
    var bookdt = $("#hfdate").val();
    $.ajax({

        type: "POST",
        url: "index.aspx/getbookingdetails",
        data: '{slots: "' + slots + '",time:"' + timing + '",persons:"' + nper + '",bookdt:"' + bookdt + '",type:"1"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnSuccessCall,
        error: OnErrorCall

    });
    function OnSuccessCall(response) {

        $("#lblbookings").html(response.d)

    }

    function OnErrorCall(response) {

        alert(response.status + " " + response.statusText);

    }
}
function fnbookings(bookid) {
    $("#hfbookings").val(bookid);
    $("#btncontinueone").show();
}
function fnbooksummary() {
    var fname = $("#txtfname").val();
    var lname = $("#txtlname").val();
    var cpno = $("#txtcpno").val();
    var mail = $("#txtmailid").val();
    var company = $("#txtcompany").val();
    var notes = $("#txtremarks").val();

    var checkboxes =
                document.getElementsByName('laptop');

    var result = "";

    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            result += checkboxes[i].value
             + ", ";
        }
    }

    var specialarrange = result;
    $("#hfsparrange").val(result);
    var bdate = $("#hfdate").val();
    var Time = $("#hfbtime").val();
    var nps = $("#qty1").val();
    $("#customer").html(fname + ' ' + lname);
    $("#mail").html(mail);
    $("#contact").html(cpno);
    $("#company").html(company);
    $("#specialarrange").html(specialarrange);
    $("#notes").html(notes);
    $("#bdate").html(bdate);
    $("#Time").html(Time);
    $("#nps").html(nps);
}
setInterval(fnbindcontinue, 1000);
function fnbindcontinue() {
    var fname = $("#txtfname").val();
    var lname = $("#txtlname").val();
    var cpno = $("#txtcpno").val();
    var mailid = $("#txtmailid").val();
    var chkterms = $("#chkterms").is(":checked");
    if (fname != "" & lname != "" & cpno != "" & mailid != "" & chkterms == true) {
        $("#btncontinuetwo").show();
    }
    else {
        $("#btncontinuetwo").hide();
    }
}
function fncart(id) {
    $.ajax({

        type: "POST",
        url: "index.aspx/updateCartdetails",
        data: '{itmid: "' + id + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnSuccessCall,
        error: OnErrorCall

    });
    function OnSuccessCall(response) {
        var split = response.d.split("@@");
        $("#ttlitems").html(split[0]);
        $("#cartdata").html(split[1]);
    }

    function OnErrorCall(response) {

        alert(response.status + " " + response.statusText);

    }
}

function fndelete(id) {
    $.ajax({

        type: "POST",
        url: "index.aspx/RemoveCartdetails",
        data: '{itmid: "' + id + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnSuccessCall,
        error: OnErrorCall

    });
    function OnSuccessCall(response) {
        var split = response.d.split("@@");
        $("#ttlitems").html(split[0]);
        $("#cartdata").html(split[1]);
    }

    function OnErrorCall(response) {

        alert(response.status + " " + response.statusText);

    }
}

function chkcartdetails() {
    var rb = document.getElementById("rdbdeltypes");
    var radio = rb.getElementsByTagName("input");
    var label = rb.getElementsByTagName("label");
    var long = $("#hflongitude").val();
    var lati = $("#hflatitude").val();
    var chk = 0;
    var time = $("#hftime").val();
    var rdbval = "";
    for (var i = 0; i < radio.length; i++) {
        if (radio[i].checked) {
            chk = 1;
            rdbval = radio[i].value;
        }
    }
    $("#hfrdbval").val(rdbval);
    if (chk == 0) {
        alert('Choose Delivery Option..');
    }
    else {
        var itmcnt = $("#ttlitems").html();
        if (parseInt(itmcnt) > 0) {
            if (rdbval == 1) {
                $("#bookingCart").hide();
                $("#bookingDetails").show();
                $("#btncartcontinue").hide();
                changeItemState(true);
                $("#tblpersons").show();
                $("#lblslots").show();
                $("#lbltimings").show();
                $("#lblmsg").show();
                $("#lblbookings").show();
                $("#tbldtake").hide();
                $(".datepicker").datepicker('option', 'maxDate', 90);
                $("#devpersons").show();
            }
            else {

                $.ajax({
                    type: "POST",
                    url: "index.aspx/getDeliverySlots",
                    data: '{rdbdel: "' + rdbval + '",longi: "' + long + '",lati: "' + lati + '",time:"' + time + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccessCall,
                    error: OnErrorCall
                });
                function OnSuccessCall(response) {
                    var split = response.d.split("@@");
                    if (parseInt(split[0]) == 0) {
                        alert('Delivery not available at your location..');
                    }
                    else {
                        $("#dtakeslots").html(split[1]);
                        $("#bookingCart").hide();
                        $("#bookingDetails").show();
                        $("#btncartcontinue").hide();
                        changeItemState(true);
                        $("#tblpersons").hide();
                        $("#lblslots").hide();
                        $("#lbltimings").hide();
                        $("#lblmsg").hide();
                        $("#lblbookings").hide();
                        $("#tbldtake").show();
                        $(".datepicker").datepicker('option', 'maxDate', 0);
                        $("#devpersons").hide();
                    }
                }

                function OnErrorCall(response) {

                    alert(response.status + " " + response.statusText);

                }
            }
        }
        else {
            alert('Choose Items to Continue..');
        }
    }
    return false;
}

function gotoprevious() {
    $("#bookingCart").show();
    $("#bookingDetails").hide();
    $("#btncartcontinue").show();
    changeItemState(false);
    $("#tblpersons").show();
    $("#lblslots").show();
    $("#lbltimings").show();
    $("#lblmsg").show();
    $("#lblbookings").show();
    $("#tbldtake").hide();
    $(".datepicker").datepicker('option', 'maxDate', 90);
    $("#devpersons").show();
}

function changeItemState(disable) {
    rb = document.getElementById("rdbdeltypes");

    var rbItems = rb.getElementsByTagName('input');

    for (var itemIndex = 0; itemIndex < rbItems.length; itemIndex++) {
        rbItems[itemIndex].disabled = disable;
    }
}

function fngetdeldata(id)
{
    var timing = $("#rdbdtiming" + id + "").val();
    var etime = timing;
    $("#hfbtime").val(timing);
    $("#btncontinueone").show();
}

function getSlotCount() {
    $.ajax({

        type: "POST",
        url: "Dashboard.aspx/fetchNewSlotCount",
        data: '{type: "' + 1 + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnSuccessCall,
        error: OnErrorCall

    });
    function OnSuccessCall(response) {
        var split = response.d.split("#");
        for (var i = 3; i <= 5; i++) {
            $("#newval" + i + "").html(split[i - 3]);
        }
    }

    function OnErrorCall(response) {

        alert(response.status + " " + response.statusText);

    }
}
setInterval(getSlotCount, 10000);