<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<%@ include file="/WEB-INF/jsp/header.jsp" %>

<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCLHRdca8dIAKOzZ6s4XUB4GXh7RDWJPac&sensor=true"></script>
<script type="text/javascript">

    var lat = 0;
    var lon = 0;
    var marker = null;
    var map = null;
    var geocoder = new google.maps.Geocoder();

    $(document).ready(function () {
        
        lat='${latitud}';
        lon='${longitud}';
        console.log('lat:'+lat+' lon:'+lon);
        initializeMap();
        $('.submit').keypress(function (event) {
            if (event.which == 13) {
                $('#incidente').submit();
            }
        });
    });

    function initializeMap() {
        var mapOptions = {
            center: new google.maps.LatLng(4.6431503595568, -74.092328125),
            zoom: 12,
            mapTypeId: google.maps.MapTypeId.HYBRID,
            mapTypeControl: true,
            mapTypeControlOptions: {
                style: google.maps.MapTypeControlStyle.DROPDOWN_MENU
            }
        };
        map = new google.maps.Map(document.getElementById("map"), mapOptions);

        if (lat != '' && lon != '') {
            var latLng = new google.maps.LatLng(lat, lon);
            setFirstMarker(latLng);
            map.setCenter(latLng);
            map.setZoom(18);
        } 
        google.maps.event.addListener(map, 'click', function (evt) {
            setFirstMarker(evt.latLng);
            if (map.getZoom() < 13) {
                map.setZoom(13);
            }
        }); 
    }

    function setFirstMarker(latLng) {
        if (marker == null) {
            marker = new google.maps.Marker({
                position: latLng,
                title: '',
                map: map,
                draggable: true
            });
            google.maps.event.addListener(marker, 'dragend', function () {
                geocodePosition(marker.getPosition());
            });
        } else {
            marker.setPosition(latLng);
        }
        geocodePosition(latLng);
    }

    function geocodePosition(pos) {
        /*geocoder.geocode({latLng: pos}, function (responses) {
            if (responses && responses.length > 0) {
                $('#aproxaddress').val(responses[0].formatted_address);
            } else {
                $('#aproxaddress').val('No se puede determinar esta dirección');
            }
        });*/

        $('#latitud').val(pos.lat());
        $('#longitud').val(pos.lng());
        map.setCenter(pos);

    }
</script>


<div class="container">
    <form:form modelAttribute="incidente" action="incidente" method="post">
        <h3>Datos del incidente</h3>
        <p>
            <form:label for="tipocoordenada.tipo" path="tipocoordenada.tipo" cssErrorClass="error">Tipo</form:label><br/>
            <form:select path="tipocoordenada.tipo">
                <form:options items="${listaTipos}" itemValue="tipo" itemLabel="descripcion"/>
            </form:select>
            <form:errors path="tipocoordenada.tipo" />			
        </p>
        <p>	
            <form:label for="descripcion" path="descripcion" cssErrorClass="error">Decripción</form:label><br/>
            <form:input path="descripcion" /> <form:errors path="descripcion" />
        </p>
        <label>Ubicación en el mapa</label>
        <div id="map"></div>
        
        <p>	
            <form:hidden path="latitud" />
            <form:hidden path="longitud" />
            <input type="submit" />
        </p>
    </form:form>
</div>

<%@ include file="/WEB-INF/jsp/footer.jsp" %>
