<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Org.aspx.cs" Inherits="E_OfficePI.Page.HR.Org" %>


<!DOCTYPE html>
<html>
<head>
<title></title>
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<link href="../../Treeview/style.css" rel="stylesheet" />
<link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.ui.position.js"></script>
 <script src="../../js/engine.js"></script>
<style>
    body{
            font-family:'TH SarabunPSK';
            font-size:18px !important;
            
        }
</style>
<script>
   
   
    function Focusid(x) {
        $('#Hdparentorgid').val(x);
    }
    $(document).ready(function () {
       
        Rendertree();
        $.contextMenu({
            selector: '.context-menu-one',
            callback: function (key, options) {
               
                if (key == "Add") {
                   
                    parent.Addorg($('#Hdparentorgid').val());
                }
                else if (key == "Edit") {
                    parent.Editorg($('#Hdparentorgid').val());
                }
                else if (key == "Delete") {
                    parent.Deleteorg($('#Hdparentorgid').val());
                }
                //var m = "clicked: " + key;
                //window.console && console.log(m) || alert(m);
            },
            items: {
                "Add": { name: "เพิ่มผังใหม่"},
                "Edit": { name: "แก้ไขผัง" },
                "Delete": { name: "ลบผัง" }
            }
        });
    });
   
    function Rendersubtree(res) {
        var j = 0;
        var html = '';
        html += '<ul>';
        for (j = 0; j < res.length; j++) {
            html += '<li ><a style="cursor:pointer;" onclick="parent.Orginfo(' + res[j]['OrgId'] + ');"  onmouseover="Focusid(' + res[j]['OrgId'] + ');" class="context-menu-one" >' + res[j]['OrgName'] + '</a>';
            if (res[j]['Trees'].length > 0) {
                html += Rendersubtree(res[j]['Trees']);
            }
            else {
                html += '</li>';
            }
        }
        html += '</ul>';
        return html;
    }
    function Rendertree() {
        var html = '';
        var i = 0;
        html += '<ul>';
        $.ajax({
            type: "POST",
            url: "Org.aspx/RenderTree",
            data: "{}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                html += '<li><a style="cursor:pointer;" onclick="parent.Orginfo(' + response.d['OrgId'] + ');"  onmouseover="Focusid(' + response.d['OrgId'] + ');" class="context-menu-one">' + response.d['OrgName'] + '</a>';
                html += Rendersubtree(response.d['Trees']);
                html += '</li></ul>';
                $('#Divtree').html(html);
                
                $('ul').each(function () {
                    $this = $(this);
                    $this.find("li").has("ul").addClass("hasSubmenu");
                });
                // Find the last li in each level
                $('li:last-child').each(function () {
                    $this = $(this);
                    // Check if LI has children
                    if ($this.children('ul').length === 0) {
                        // Add border-left in every UL where the last LI has not children
                        $this.closest('ul').css("border-left", "1px solid gray");
                    } else {
                        // Add border in child LI, except in the last one
                        $this.closest('ul').children("li").not(":last").css("border-left", "1px solid gray");
                        // Add the class "addBorderBefore" to create the pseudo-element :defore in the last li
                        $this.closest('ul').children("li").last().children("a").addClass("addBorderBefore");
                        // Add margin in the first level of the list
                        $this.closest('ul').css("margin-top", "20px");
                        // Add margin in other levels of the list
                        $this.closest('ul').find("li").children("ul").css("margin-top", "20px");
                    };
                });
                // Add bold in li and levels above
                $('ul li').each(function () {
                    $this = $(this);
                    $this.mouseenter(function () {
                        $(this).children("a").css({ "font-weight": "bold", "color": "#336b9b" });
                    });
                    $this.mouseleave(function () {
                        $(this).children("a").css({ "font-weight": "normal", "color": "#428bca" });
                    });
                });
                // Add button to expand and condense - Using FontAwesome
                $('ul li.hasSubmenu').each(function () {
                    $this = $(this);
                    $this.prepend("<a href='#'><i class='fa fa-minus-circle'></i><i style='display:none;' class='fa fa-plus-circle'></i></a>");
                    $this.children("a").not(":last").removeClass().addClass("toogle");
                });
                // Actions to expand and consense
                $('ul li.hasSubmenu a.toogle').click(function () {
                    $this = $(this);
                    $this.closest("li").children("ul").toggle("slow");
                    $this.children("i").toggle();
                    return false;
                });
               
            },
            async: false,
            error: function (er) {
                Msgbox(er.status);
            }
        });
    }
</script>
<style>
    button
    {
        font-size:18px;
        border-radius:1px;
    }
</style>
</head>

<body style="font-family:TH SarabunPSK;color:black;">
        <div id="Divtree">

        </div>
       <input type="hidden" id="Hdparentorgid" value="" />

</body>
</html>
