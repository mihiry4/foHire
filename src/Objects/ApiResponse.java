package Objects;

import org.json.JSONObject;

public final class ApiResponse extends JSONObject {
    public ApiResponse() {
        try {
            this.put("status", 400);
            this.put("message", "");
        } catch (Exception var2) {
            ;
        }

    }

    public ApiResponse setStatus(Integer status) {
        try {
            this.put("status", status);
        } catch (Exception var3) {
            ;
        }

        return this;
    }

    public ApiResponse setMessage(String message) {
        try {
            this.put("message", message);
        } catch (Exception var3) {
            ;
        }

        return this;
    }

    public ApiResponse setPayload(String key, Object value) {
        try {
            this.put(key, value);
        } catch (Exception var4) {
            ;
        }

        return this;
    }

    public Integer getStatus() {
        try {
            return this.getInt("status");
        } catch (Exception var2) {
            return null;
        }
    }
}
