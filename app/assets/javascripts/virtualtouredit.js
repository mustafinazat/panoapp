/**
 * Created by 1 on 13.02.2018.
 */

var tbody = document.getElementById("conns_table_tbody");
var textarea = document.getElementById("virtualtour_connections");
var close = document.getElementsByClassName("deleteitem");
create_table();

function create_table()
{

   var ar_of_conns = textarea.textContent.split("/");

    for (var i =0; i<ar_of_conns.length-1; i++)
    {

        var connect_arrC=ar_of_conns[i].split(";");
console.log(connect_arrC);
        var elemoflist = document.createElement('tr');

        for (var j=0; j<connect_arrC.length-1;j++)
        {
            var th = document.createElement('th');
            th.textContent = connect_arrC[j];
            elemoflist.appendChild(th);
        }

        var span = document.createElement("th");
        var txt = document.createElement("i");
        txt.className ="fa fa-times";
        span.className = "deleteitem";
        span.appendChild(txt);
        elemoflist.appendChild(span);
        tbody.appendChild(elemoflist);

        for (var k = 0; k < close.length; k++) {
            close[k].onclick = function() {
                var tr = this.parentElement;
                tr.parentElement.removeChild(tr);
                updateTextarea();
            }
        }
    }
}




function addToList() {
    var connect_arr=[];

    connect_arr[0] = $('#pano1 > .swiper-slide-active > h4')[0].innerText.replace(/Панорама/g,"");
    connect_arr[1] = $('.coords')[0].value;
    connect_arr[2] = $('#infospot-text')[0].value;
    connect_arr[3] = $('#pano2 > .swiper-slide-active > h4')[0].innerText.replace(/Панорама/g,"");
    var elemoflist = document.createElement('tr');
   for (var i=0; i<connect_arr.length;i++)
   {
       var th = document.createElement('th');
       th.textContent = connect_arr[i];
       elemoflist.appendChild(th);
   }

    var span = document.createElement("th");
    var txt = document.createElement("i");
    txt.className ="fa fa-times";
    span.className = "deleteitem";
    span.appendChild(txt);
    elemoflist.appendChild(span);
    tbody.appendChild(elemoflist);

    for (var i = 0; i < close.length; i++) {
        close[i].onclick = function() {
            var tr = this.parentElement;
            tr.parentElement.removeChild(tr);
            updateTextarea();
        }
    }
    updateTextarea();
}

function updateTextarea()
{

    textarea.textContent="";
    var elems = tbody.querySelectorAll("tr");
    console.log(elems);

    for(var i=0; i<elems.length; i++)
    {
        var th = elems[i].querySelectorAll("th");
        console.log(th);
        var elem_str="";
        for (var j=0; j<th.length-1;j++)
        {

            var th_val = th[j].textContent;
            elem_str+=th_val+";";
        }
        textarea.textContent+=((~elem_str.indexOf("Панорама"))? elem_str.replace(/Панорама/g,"") : elem_str)+'/';
    }
}


var panoramaContainer, mainContainer, closeButton,  viewer, panorama,progressBar, progress;
panoramaContainer = document.getElementById( 'panorama-container' );
mainContainer = document.getElementById( 'main-container');
progressBar = document.getElementById( 'progress_bar' );
closeButton = panoramaContainer.querySelector( '.closepano' );

function OpenPanorama () {

    var img = $('#pano1 > .swiper-slide-active >img');
    var panourl = img[0].src;
    console.log(panourl);
    console.log(img);

    setupPanolens();

    panorama = new PANOLENS.ImagePanorama(panourl);

    infospot = new PANOLENS.Infospot( 350, PANOLENS.DataImage.Info );
    panorama.addEventListener( 'progress', function ( event ) {
        progress = event.progress.loaded / event.progress.total * 100;
        progressBar.style.width = progress + '%';
        if ( progress === 100 ) {
            progressBar.style.opacity = 0;
        }
    } );
    viewer.add( panorama );
    panoramaContainer.classList.add( 'open' );




    PANOLENS.Viewer.prototype.outputInfospotPosition = function() {
        var t, e, n, i;
        if (t = this.raycaster.intersectObject(this.panorama, !0), t.length > 0) switch (e = t[0].point, n = this.panorama.getWorldPosition(), i = new THREE.Vector3(-(e.x - n.x).toFixed(2), (e.y - n.y).toFixed(2), (e.z - n.z).toFixed(2)), this.options.output) {
            case "console":
                console.info(i.x + ", " + i.y + ", " + i.z);
                break;
            case "fortour":
                console.info(i.x + ", " + i.y + ", " + i.z);
                infospot.position.set( i.x, i.y, i.z );
                panorama.toggleInfospotVisibility(true);
                panorama.add(infospot);
                document.querySelector(".coords").value = i.x + ", " + i.y + ", " + i.z;
                break;
            case "overlay":
                this.outputDivElement.textContent = i.x + ", " + i.y + ", " + i.z
        }
    };

};
function setupPanolens () {
    viewer = new PANOLENS.Viewer( { container: mainContainer, output: 'fortour' , autoHideInfospot: false, autoHideControlBar: true } );
    viewer.OUTPUT_INFOSPOT = 1;


};

function disposePanorama () {
    panorama.dispose();
    viewer.remove( panorama );
    panorama = null;
};


function disposeViewer () {
    viewer.dispose();
    mainContainer.innerHTML = '';
    viewer = null;
};


function outputViewer () {

    if ( viewer.OUTPUT_INFOSPOT == 1)
    {
        viewer.OUTPUT_INFOSPOT = 0;
    }
    else
    {
        viewer.OUTPUT_INFOSPOT = 1;
    }

};

function init () {
    mainContainer.addEventListener( 'click', function () {
    }, false );


  // Dispose panorama when close
    closeButton.addEventListener( 'click', function () {
        disposePanorama();
        disposeViewer();
        progressBar.style.width = 0;
        progressBar.style.opacity = 1;
        panoramaContainer.classList.remove( 'open' );
    }, false );

}
init();




function load_photos_to_swiper(array, type)
{

    var output = document.getElementsByClassName('swiper-wrapper');
    var counter = output[0].querySelectorAll(".swiper-slide").length-2;
    console.log(counter);
    var files = array;
    if (!files.length) {

    } else {


        for (var i = 0; i < files.length; i++) {

            var div = document.createElement("div");
            div.classList.add("d-flex", "justify-content-around", "swiper-slide");
            div.style.height = "30vh";
            var img = document.createElement("img");
            if (type =="erb"){   img.src = files[i]}
            if (type =="vk"){   img.src = files[i].src_xxxbig;}
            if (type =="files"){ img.src = window.URL.createObjectURL(files[i]);}
            img.classList.add("img-fluid");
            div.appendChild(img);
            var info = document.createElement("h4");
            if (type =="erb"){   info.innerHTML = "Панорама "+ (i+1);}
            if (type =="files"){  info.innerHTML = "Панорама "+ (i+1+counter);}

            div.appendChild(info);

            output[0].appendChild(div);
        }


        output[1].innerHTML =  output[0].innerHTML;


        var mySwiper = new Swiper ('.swiper-container', {
            loop: true,
            pagination: '.swiper-pagination',
            paginationClickable: true,
            nextButton: '.swiper-button-next',
            prevButton: '.swiper-button-prev'
        });
    }

}





function handleFiles(e) {
    load_photos_to_swiper(e.target.files, "files")
}



// проверяем поддерживает ли браузер file API
if(window.File && window.FileReader && window.FileList && window.Blob) {
    // если да, то как только страница загрузится
    onload = function () {
        // вешаем обработчик события, срабатывающий при изменении input'а

        document.querySelector('#images').addEventListener('change', handleFiles, false);
    }
// если нет, то предупреждаем, что демо работать не будет
} else {
    alert('К сожалению ваш браузер не поддерживает file API');
}
