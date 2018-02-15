/**
 * Created by 1 on 13.02.2018.
 */

var listofconns= document.getElementById("listOfConn");
var textarea = document.getElementById("virtualtour_connections");
function addToList() {
    var h4first = $('#pano1 > .swiper-slide-active > h4');
    var panofirst = h4first[0].innerText;
    var ConnectionDotCoord = $('.coords');
    var coords = ConnectionDotCoord[0].value;
    var infospotText = document.getElementById("infospot-text").value;
    var h4second = $('#pano2 > .swiper-slide-active > h4');
    var panosecond = h4second[0].innerText;
    var allparts = "Панорама " +panofirst.replace(/\D+/g,"") +";"+coords+";"+infospotText+"; Панорама "+panosecond.replace(/\D+/g,"");
    var elemoflist = document.createElement('li');
    elemoflist.className = 'list-group-item';
    elemoflist.innerHTML = allparts;
    var span = document.createElement("SPAN");
    var txt = document.createTextNode("\u00D7");
    span.className = "deleteitem";
    span.appendChild(txt);
    elemoflist.appendChild(span);

    listofconns.appendChild(elemoflist);
    for (var i = 0; i < close.length; i++) {
        close[i].onclick = function() {
            var li = this.parentElement;
            li.parentElement.removeChild(li);
            updateTextarea();
        }
    }
    updateTextarea();
}

function updateTextarea()
{
    textarea.textContent="";
    var elems = listofconns.childNodes;
    for(var i=1; i<elems.length; i++)
    {
        var elem = elems[i].childNodes[0].data;
        textarea.textContent+=((~elem.indexOf("Панорама"))? elem.replace(/Панорама/g,"") : elem)   +'/';
    }
//textarea.textContent = textarea.textContent.replace(/\s+/g, '');
}
var close = document.getElementsByClassName("deleteitem");

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
    viewer = new PANOLENS.Viewer( { container: mainContainer, output: 'fortour' , autoHideInfospot: false } );
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
    var files = array;
    if (!files.length) {
        output[0].innerHTML = "";
        output[1].innerHTML ="";
    } else {
        output[0].innerHTML = "";
        output[1].innerHTML ="";

        for (var i = 0; i < files.length; i++) {
            var div = document.createElement("div");
            div.classList.add("d-flex", "justify-content-around", "swiper-slide");
            div.style.height = "30vh";
            var img = document.createElement("img");
            if (type =="vk"){   img.src = files[i].src_xxxbig;}
            if (type =="files"){ img.src = window.URL.createObjectURL(files[i]);}
            img.classList.add("img-fluid");
            div.appendChild(img);
            var info = document.createElement("h4");
            info.innerHTML = "Панорама "+ (i+1);
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
