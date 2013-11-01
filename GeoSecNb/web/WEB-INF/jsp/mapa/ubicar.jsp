<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<%@ include file="/WEB-INF/jsp/header.jsp" %>

<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCLHRdca8dIAKOzZ6s4XUB4GXh7RDWJPac&sensor=true"></script>
<script type="text/javascript">

    var infoWindow = null;
    var map = null;
    var json = '';
    var bounds = null;
    var marker=null;

    $(document).ready(function() {
        $('.button').button();

        initializeMap();

    });

    function initializeMap() {
        infoWindows = new Array();

        var mapOptions = {
            center: new google.maps.LatLng(4.6431503595568, -74.092328125),
            zoom: 8,
            mapTypeId: google.maps.MapTypeId.HYBRID,
            mapTypeControl: true,
            mapTypeControlOptions: {
                style: google.maps.MapTypeControlStyle.DROPDOWN_MENU
            }
        };
        map = new google.maps.Map(document.getElementById("mapa"), mapOptions);
    }

    function sendFilter(){
        var sLat=$('#latitud').val().replace(",",".");
        var sLon=$('#longitud').val().replace(",",".");
        var lat=parseFloat(sLat);
        var lng=parseFloat(sLon);
        console.log('latlng:'+lat+'-'+lng);
        if(isNaN(lat)||isNaN(lng)){
            alert('Valores no válidos!!!');
            return;
        }
        var latLng = new google.maps.LatLng(lat, lng);
        setMarker(latLng);
    }

    function setMarker(latLng) {
        if(marker==null){
            marker = new google.maps.Marker({
                position: latLng,
                title: '',
                map: map,
                draggable: false
            });
        }else{
           marker.setPosition(latLng);
        }
        map.setCenter(latLng);
        map.setZoom(8);
    }


</script>


<div class="principal rounded5">
    <div class="opciones rounded5">
        <div id="content" class="fechahora"></div>

        <div class="fechahora">
            <label for="latitud">Ingrese las coordenadas</label><br/>
            <span class="tipoincidente">
                <span class="labelinterno">Latitud:</span>
                <input type="text" id="latitud" class="rounded3 date" value="" />
            </span>
            <span class="tipoincidente">
                <span class="labelinterno">Longitud:</span>
                <input type="text" id="longitud" class="rounded3 date" value="" />
            </span>
        </div>
        <div class="fechahora lineatop">
            <input type="button" class="button" onclick="sendFilter()" value="Ubicar" />
        </div>
    </div>

    <div class="principalmap">
        <div id="mapa" class="rounded5"></div>
    </div>
</div>

<script type="text/javascript">

var requestData;
var clientId = '278877328597';
var apiKey = 'AIzaSyA72P47B9mnKhJAZG88hOGf2u5Nrfnqn_A';
var scopes = 'https://www.googleapis.com/auth/plus.me';

function handleClientLoad() {
    gapi.client.setApiKey(apiKey);
    window.setTimeout(checkAuth, 1);
}

function checkAuth() {
    gapi.auth.authorize({client_id: clientId, scope: scopes, immediate: true}, handleAuthResult);
}

function handleAuthResult(authResult) {
    if (authResult && !authResult.error) {
        makeApiCall();
    } else {
        window.location.href='<spring:url value="/" htmlEscape="true" />';
    }
}

function handleAuthClick(event) {
    gapi.auth.authorize({client_id: clientId, scope: scopes, immediate: false}, handleAuthResult);
    return false;
}

function makeApiCall() {
    gapi.client.load('plus', 'v1', function() {
        var request = gapi.client.plus.people.get({
            'userId': 'me'
        });
        request.execute(function(resp) {
            requestData = resp;
            var heading = document.createElement('h4');
            var image = document.createElement('img');
            image.src = resp.image.url;
            heading.appendChild(image);
            $(heading).append($('<span>'+resp.displayName+'</span>'));
            document.getElementById('content').appendChild(heading);
        });
    });
}

function auth() {
    var config = {
        'client_id': 'YOUR CLIENT ID',
        'scope': 'https://www.googleapis.com/auth/urlshortener'
    };
    gapi.auth.authorize(config, function() {
        console.log('login complete');
        console.log(gapi.auth.getToken());
    });
}

</script>
<script src="https://apis.google.com/js/client.js?onload=handleClientLoad"></script>


<div class="clear"></div>
<%@ include file="/WEB-INF/jsp/footer.jsp" %>
