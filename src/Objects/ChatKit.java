package Objects;

import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.JsonNode;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.request.GetRequest;
import com.mashape.unirest.request.HttpRequestWithBody;
import io.jsonwebtoken.JwtBuilder;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import javax.crypto.spec.SecretKeySpec;
import java.security.Key;
import java.util.*;

public final class ChatKit {
    private String apiEndPoint;
    private String instance = "";
    private String key = "";
    private String secret = "";
    private Date expireIn = null;
    private String token = null;

    public ChatKit(Map<String, String> options) throws Exception {
        if (! options.containsKey("instanceLocator")) {
            throw new Exception("You must provide an instance_locator");
        } else if (! options.containsKey("key")) {
            throw new Exception("You must provide a key");
        } else {
            String[] instanceSplit = ((String) options.get("instanceLocator")).split(":");
            String[] keySplit = ((String) options.get("key")).split(":");
            if (instanceSplit.length != 3) {
                throw new MissingFormatArgumentException("v1:us1:instance");
            } else if (keySplit.length != 2) {
                throw new MissingFormatArgumentException("key:secret");
            } else {
                this.instance = instanceSplit[2];
                this.key = keySplit[0];
                this.secret = keySplit[1];
                this.apiEndPoint = "https://us1.pusherplatform.io/services/chatkit/v1/" + this.instance + "/";
                if (options.containsKey("expireIn")) {
                    this.expireIn = this.getDateFromMinute(Long.parseLong((String) options.get("expireIn")));
                } else {
                    this.expireIn = this.getDateFromMinute(86400L);
                }

            }
        }
    }

    protected Date getDateFromMinute(long seconds) {
        long ttlMillis = seconds * 1000L;
        long expMillis = System.currentTimeMillis() + ttlMillis;
        return new Date(expMillis);
    }

    protected ApiResponse apiRequest(String service) throws Exception {
        return this.apiRequest(service, "get", (Map) null);
    }

    protected ApiResponse apiRequest(String service, String method) throws Exception {
        return this.apiRequest(service, method, (Map) null);
    }

    protected ApiResponse apiRequest(String service, String method, Map<String, Object> requestData) throws Exception {
        String requestUrl = this.apiEndPoint + service;
        ApiResponse apiResponse = null;
        String var6 = method.toLowerCase();
        byte var7 = - 1;
        switch (var6.hashCode()) {
            case - 1335458389:
                if (var6.equals("delete")) {
                    var7 = 2;
                }
                break;
            case 102230:
                if (var6.equals("get")) {
                    var7 = 3;
                }
                break;
            case 111375:
                if (var6.equals("put")) {
                    var7 = 1;
                }
                break;
            case 3446944:
                if (var6.equals("post")) {
                    var7 = 0;
                }
        }

        switch (var7) {
            case 0:
            case 1:
            case 2:
                apiResponse = this.requestWithBody(requestUrl, requestData, method);
                break;
            case 3:
                apiResponse = this.getRequest(requestUrl);
                break;
            default:
                apiResponse = null;
        }

        return apiResponse;
    }

    protected ApiResponse getRequest(String requestUrl) throws Exception {
        GetRequest getRequest = Unirest.get(requestUrl);
        HttpResponse<JsonNode> response = getRequest.header("Authorization", "Bearer " + this.token).header("Content-Type", "application/json").asJson();
        return response != null ? this.handleResponse(response) : null;
    }

    protected ApiResponse requestWithBody(String requestUrl, Map<String, Object> requestData, String method) throws Exception {
        HttpRequestWithBody requestWithBody = null;
        if (method.equals("put")) {
            requestWithBody = Unirest.put(requestUrl);
        } else if (method.equals("delete")) {
            requestWithBody = Unirest.delete(requestUrl);
        } else {
            requestWithBody = Unirest.post(requestUrl);
        }

        requestWithBody.header("Authorization", "Bearer " + this.token).header("Content-Type", "application/json");
        if (requestData != null) {
            JSONObject json = new JSONObject(requestData);
            requestWithBody.body(json.toString());
        }

        HttpResponse<JsonNode> response = requestWithBody.asJson();
        return response != null ? this.handleResponse(response) : null;
    }

    protected ApiResponse handleResponse(HttpResponse<JsonNode> response) throws JSONException {
        ApiResponse apiResponse = new ApiResponse();
        if (response.getStatus() != 201 && response.getStatus() != 200 && response.getStatus() != 204) {
            JSONObject responseBody = ((JsonNode) response.getBody()).getObject();
            apiResponse.setStatus(response.getStatus()).setPayload("error", responseBody.optString("error")).setMessage(responseBody.optString("error_description"));
        } else {
            apiResponse.setStatus(200).setPayload("payload", this.handleResponseData((JsonNode) response.getBody()));
        }

        return apiResponse;
    }

    protected Object handleResponseData(JsonNode responseBody) throws JSONException {
        if (responseBody == null) {
            return null;
        } else if (! responseBody.isArray()) {
            return responseBody.getObject();
        } else {
            JSONArray data = responseBody.getArray();
            List<JSONObject> results = new ArrayList();

            for (int i = 0; i < data.length(); ++ i) {
                results.add((JSONObject) data.get(i));
            }

            return results;
        }
    }

    protected String generateRefreshToken(String userId, boolean su) {
        return this.generateToken(userId, su, true);
    }

    protected String generateToken(String userId, boolean su) {
        return this.generateToken(userId, su, false);
    }

    private String generateToken(String userId, boolean su, boolean refresh) {
        SignatureAlgorithm signatureAlgorithm = SignatureAlgorithm.HS256;
        Map<String, Object> header = new HashMap();
        header.put("typ", "JWT");
        header.put("alg", signatureAlgorithm);
        byte[] apiKeySecretBytes = this.secret.getBytes();
        Key signingKey = new SecretKeySpec(apiKeySecretBytes, signatureAlgorithm.getJcaName());
        String issueString = "api_keys/" + this.key;
        JwtBuilder builder = Jwts.builder().setHeader(header).setIssuedAt(new Date()).setExpiration(this.expireIn).setIssuer(issueString).claim("instance", this.instance).signWith(signatureAlgorithm, signingKey);
        if (userId != null) {
            builder.setSubject(userId);
        }

        if (su) {
            builder.claim("su", true);
        }

        if (refresh) {
            builder.claim("refresh", true);
        }

        return builder.compact();
    }

    protected String serverToken() {
        String adminUser = "1";
        return this.generateToken(adminUser, true);
    }

    protected String serverToken(String userId) {
        return this.generateToken(userId, true);
    }

    public ApiResponse authenticate(String userId) throws Exception {
        if (userId == null) {
            throw new Exception("You must provide a user id");
        } else {
            String accessToken = this.generateToken(userId, false);
            String refreshToken = this.generateRefreshToken(userId, false);
            ApiResponse responseBody = new ApiResponse();
            responseBody.setStatus(200).setPayload("access_token", accessToken).setPayload("token_type", "access_token").setPayload("refresh_token", refreshToken).setPayload("expires_in", this.expireIn.getTime() / 1000L).setPayload("user_id", userId);
            return responseBody;
        }
    }

    public ApiResponse getUsers() throws Exception {
        this.token = this.serverToken();
        return this.apiRequest("users");
    }

    public ApiResponse getUsers(List<String> ids) throws Exception {
        this.token = this.serverToken();
        return this.apiRequest("users_by_ids?user_ids=" + String.join(",", ids));
    }

    public ApiResponse getUser(String userId) throws Exception {
        this.token = this.serverToken();
        return this.apiRequest("users/" + userId);
    }

    public ApiResponse createUser(String userId, Map<String, Object> data) throws Exception {
        this.token = this.serverToken();
        if (userId == null) {
            throw new Exception("You must provide an id");
        } else if (data.containsKey("name") && data.get("name").toString().length() != 0) {
            data.put("id", userId);
            return this.apiRequest("users", "post", data);
        } else {
            throw new Exception("You must provide a name");
        }
    }

    public ApiResponse updateUser(String userId, Map<String, Object> data) throws Exception {
        if (userId == null) {
            throw new Exception("You must provide an id");
        } else {
            this.token = this.serverToken(userId);
            return this.apiRequest("users/" + userId, "put", data);
        }
    }

    public ApiResponse deleteUser(String userId) throws Exception {
        this.token = this.serverToken();
        return this.apiRequest("users/" + userId, "delete", (Map) null);
    }

    public ApiResponse getAllRooms() throws Exception {
        this.token = this.serverToken();
        return this.apiRequest("rooms");
    }

    public ApiResponse getUserRooms(String userId) throws Exception {
        if (userId == null) {
            throw new Exception("You must provide the id of the user that you wish to fetch the room list");
        } else {
            this.token = this.serverToken(userId);
            return this.apiRequest("users/" + userId + "/rooms");
        }
    }

    public ApiResponse getUserJoinableRooms(String userId) throws Exception {
        if (userId == null) {
            throw new Exception("You must provide the id of the user that you wish to fetch the room list");
        } else {
            this.token = this.serverToken(userId);
            return this.apiRequest("users/" + userId + "/rooms?joinable=true");
        }
    }

    public ApiResponse createRoom(String creatorId, Map<String, Object> data) throws Exception {
        if (creatorId == null) {
            throw new Exception("You must provide the id of the user that you wish to create the room");
        } else if (data != null && data.containsKey("name") && data.get("name").toString().length() != 0) {
            data.put("creator_id", creatorId);
            this.token = this.serverToken(creatorId);
            return this.apiRequest("rooms", "post", data);
        } else {
            throw new Exception("You must provide a room name");
        }
    }

    public ApiResponse deleteRoom(String roomId) throws Exception {
        if (roomId == null) {
            throw new Exception("You must provide the room id");
        } else {
            this.token = this.serverToken();
            return this.apiRequest("rooms/" + roomId, "delete");
        }
    }

    public ApiResponse fetchMessages(String roomId, String userId) throws Exception {
        if (roomId == null) {
            throw new Exception("You must provide the room id");
        } else {
            this.token = this.serverToken(userId);
            return this.apiRequest("rooms/" + roomId + "/messages");
        }
    }

    public ApiResponse deleteMessage(String messageId) throws Exception {
        if (messageId == null) {
            throw new Exception("You must provide the message id");
        } else {
            this.token = this.serverToken();
            return this.apiRequest("messages/" + messageId, "delete");
        }
    }
}
