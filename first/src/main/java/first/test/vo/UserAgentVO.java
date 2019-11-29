package first.test.vo;

import java.sql.Timestamp;
import java.util.Map;

public class UserAgentVO {
	private int seq;
	private String ip;
	private String countryCode;
	private Timestamp date;
	private String id;
	private String osName;
	private String osVersion;
	private String browserName;
	private String browserVersion;
	private String deviceBrand;
	private String deviceModel;
	private String referer;
	private String path;
	
	
	
	@Override
	public String toString() {
		return "UserAgentVO [seq=" + seq + ", ip=" + ip + ", countryCode=" + countryCode + ", date=" + date + ", id="
				+ id + ", osName=" + osName + ", osVersion=" + osVersion + ", browserName=" + browserName
				+ ", browserVersion=" + browserVersion + ", deviceBrand=" + deviceBrand + ", deviceModel=" + deviceModel
				+ ", referer=" + referer + ", path=" + path + "]";
	}

	public void setUA(Map<String, Object> dataMap) {
        this.browserName = (String) dataMap.get("browserName");
        this.browserVersion = (String) dataMap.get("browserVersion");
        this.osName = (String) dataMap.get("osName");
        this.osVersion = (String) dataMap.get("osVersion");
        this.deviceModel = (String) dataMap.get("deviceModel");
        this.deviceBrand = (String) dataMap.get("deviceBrand");
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}	

	public String getCountryCode() {
		return countryCode;
	}

	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getOsName() {
		return osName;
	}

	public void setOsName(String osName) {
		this.osName = osName;
	}

	public String getOsVersion() {
		return osVersion;
	}

	public void setOsVersion(String osVersion) {
		this.osVersion = osVersion;
	}

	public String getBrowserName() {
		return browserName;
	}

	public void setBrowserName(String browserName) {
		this.browserName = browserName;
	}

	public String getBrowserVersion() {
		return browserVersion;
	}

	public void setBrowserVersion(String browserVersion) {
		this.browserVersion = browserVersion;
	}

	public String getDeviceBrand() {
		return deviceBrand;
	}

	public void setDeviceBrand(String deviceBrand) {
		this.deviceBrand = deviceBrand;
	}

	public String getDeviceModel() {
		return deviceModel;
	}

	public void setDeviceModel(String deviceModel) {
		this.deviceModel = deviceModel;
	}

	public String getReferer() {
		return referer;
	}

	public void setReferer(String referer) {
		this.referer = referer;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}
	
	
	
}
