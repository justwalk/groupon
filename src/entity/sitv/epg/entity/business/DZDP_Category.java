package sitv.epg.entity.business;

import java.util.Date;
/**
 * 看吧
 * @author zhangxs
 *
 */
public class DZDP_Category implements java.io.Serializable {
	private Long id;
	private String name;
	private Long pid;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Long getPid() {
		return pid;
	}
	public void setPid(Long pid) {
		this.pid = pid;
	}
	
}
