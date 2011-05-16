function HighlightRow(chkB) {
    var IsChecked = chkB.checked;
    if (IsChecked) {
        chkB.parentElement.parentElement.style.backgroundColor = '#228b22';
        chkB.parentElement.parentElement.style.color = 'white';
    } else {
        chkB.parentElement.parentElement.style.backgroundColor = 'white';
        chkB.parentElement.parentElement.style.color = 'black';
    }
}

function SelectAllCheckboxes(spanChk) {
    var IsChecked = spanChk.checked;
    var Chk = spanChk;
    Parent = document.getElementById('GridView2');
    for (i = 0; i < Parent.rows.length; i++) {
        var tr = Parent.rows[i];
        //var td = tr.childNodes[0];                                  
        var td = tr.firstChild;
        var item = td.firstChild;
        if (item.id != Chk && item.type == "CheckBox") {
            if (item.checked != IsChecked) {
                item.click();
            }
        }
    }
}