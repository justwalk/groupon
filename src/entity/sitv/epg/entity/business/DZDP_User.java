package sitv.epg.entity.business;

import java.util.Date;
/**
 * 
 * @author wz
 *
 */
public class DZDP_User implements java.io.Serializable {
	private int id;
	private String user_id;
	private String top_address;
	private String address;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getTop_address() {
		return top_address;
	}
	public void setTop_address(String top_address) {
		this.top_address = top_address;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
}
