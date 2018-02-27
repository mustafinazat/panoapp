/**
 * Created by 1 on 13.02.2018.
 */


var  preloader = document.getElementById( 'preloader');
var progressBar = document.getElementById( 'progress_bar' );

PANOLENS.Panorama.prototype.link = function ( pano, position, imageScale, imageSrc , text) {
    var scope = this, spot, scale, img;
    this.visible = true;
    if ( !position ) {
        console.warn( 'Please specify infospot position for linking' );
        return;
    }
    // Infospot scale
    if ( imageScale !== undefined ) {
        scale = imageScale;
    } else if ( pano.linkingImageScale !== undefined ) {
        scale = pano.linkingImageScale;
    } else {
        scale = 300;
    }


    // Infospot image
    if ( imageSrc ) {

        img = imageSrc

    } else if ( pano.linkingImageURL ) {

        img = pano.linkingImageURL;

    } else {

        img = PANOLENS.DataImage.Arrow;

    }

    // Creates a new infospot
    spot = new PANOLENS.Infospot( scale, img );
    spot.position.copy( position );
    spot.addHoverText(text);
    spot.toPanorama = pano;
    spot.addEventListener( 'click', function () {
        scope.dispatchEvent( { type : 'panolens-viewer-handler', method: 'setPanorama', data: pano } );

    } );


    virtualtourtourContainer.addEventListener( 'click', function () {
        spot.element.style.display ="block";
        spot.element._width = spot.element.clientWidth;
        spot.element._height = spot.element.clientHeight;

    }, false );


    virtualtourtourContainer.addEventListener( 'touchstart', function () {
        spot.element.style.display ="block";
        spot.element._width = spot.element.clientWidth;
        spot.element._height = spot.element.clientHeight;

    }, false );



    this.linkedSpots.push( spot );

    this.add( spot );

    this.visible = false;

};

var virtualtourtourContainer;
virtualtourtourContainer = document.getElementById( 'virtualtour-container' );
var  viewer = new PANOLENS.Viewer({ container: virtualtourtourContainer, autoHideInfospot: true,  autoHideControlBar: true });



function progresspreleloader(event)
{
    {
        progress = event.progress.loaded / event.progress.total * 100;
        progressBar.style.opacity = 1;
        progressBar.style.width = progress + '%';

        preloader.style.display = "block";
        if ( progress === 100 ) {
            preloader.style.display = "none";
            progressBar.style.opacity = 0;
        }
    }
}