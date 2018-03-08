$('#exampleModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget) // Button that triggered the modal
    var url = button.data('panourl') // Extract info from data-* attributes
    // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
    // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
    var modal = $(this)
    modal.find('.iframecode').text('<iframe allowfullscreen src='+url+' height="300" width="100%"></iframe>')

})

var shareiframe = document.getElementById('shareiframe');
shareiframe.onchange = function() {
    changecolor(this);
    var links = document.getElementsByClassName("iframelink");
    for(var i = 0; i < links.length; i++)
    {  if (shareiframe.checked){links[i].style.display = "block";} else {  links[i].style.display = "none";}   }
};
function changecolor(obj){
    var ch_obj = obj.nextElementSibling;
    if (obj.checked){ ch_obj.style.color="#17a2b8"}  else { ch_obj.style.color="gray"}
}

var panoramaContainer, mainContainer, closeButton,  viewer, panorama,progressBar, progress;
panoramaContainer = document.getElementById( 'panorama-container' );
var  preloader = document.getElementById( 'preloader');
mainContainer = document.getElementById( 'main-container');
progressBar = document.getElementById( 'progress_bar' );
closeButton = panoramaContainer.querySelector( '.closepano' );

function OpenPanorama (img) {

 setupPanolens();
    //  console.log(img);
//console.log(img.previousSibling.previousSibling);
//console.log(img.parentNode.firstChild);

    if ($('#littleplanet').is(':checked')) {
        panorama = new PANOLENS.ImageLittlePlanet( img.previousSibling.previousSibling.innerText);
    }
    else
    {
        panorama = new PANOLENS.ImagePanorama( img.previousSibling.previousSibling.innerText );
    }

    panorama.addEventListener( 'progress', function ( event ) {
        progress = event.progress.loaded / event.progress.total * 100;
        progressBar.style.width = progress + '%';
        progressBar.style.position = "fixed";
        progressBar.style.opacity = 1;
        preloader.style.display = "block";
        if ( progress === 100 ) {
            preloader.style.display = "none";
            progressBar.style.opacity = 0;
        }

    } );
    viewer.add( panorama );

    panoramaContainer.classList.add( 'open' );

};

function setupPanolens () {
    viewer = new PANOLENS.Viewer( { container: mainContainer } );
};

function disposePanorama () {
    panorama.dispose();
    viewer.remove( panorama );
    //panorama = null;
};


function disposeViewer () {

    viewer.dispose();
    mainContainer.innerHTML = '';
    viewer = null;

};


function init () {

    // Dispose panorama when close
    closeButton.addEventListener( 'click', function () {
        if (panorama.loaded == true) {
            disposePanorama();
        }
        disposeViewer();
        progressBar.style.width = 0;
        progressBar.style.opacity = 1;
        panoramaContainer.classList.remove( 'open' );

    }, false );

}

init();
