<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<%@ include file="/WEB-INF/jsp/header.jsp" %>

<div class="principal rounded5">
    <button id="authorize-button" style="visibility: hidden">Ingresar con Google</button>
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
            var authorizeButton = document.getElementById('authorize-button');
            if (authResult && !authResult.error) {
                authorizeButton.style.visibility = 'hidden';
                //makeApiCall();
                window.location.href ='<spring:url value="/mapa" htmlEscape="true" />';

            } else {
                authorizeButton.style.visibility = '';
                authorizeButton.onclick = handleAuthClick;
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
                    heading.appendChild(document.createTextNode(resp.displayName));

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
    <div id="content"></div>
    <p>Obtiene usuario autenticado con Google API</p>


</div>

<div class="clear"></div>
<%@ include file="/WEB-INF/jsp/footer.jsp" %>
