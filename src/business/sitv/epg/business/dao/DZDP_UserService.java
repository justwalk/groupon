package sitv.epg.business.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import sitv.epg.entity.business.DZDP_Address;
import sitv.epg.entity.business.DZDP_Category;
import sitv.epg.entity.business.DZDP_Comment;
import sitv.epg.entity.business.DZDP_User;
import chances.epg.exception.DaoException;

/**
 * 看吧数据访问类
 * 
 * @author zhangxs
 * 
 */
@Repository
public class DZDP_UserService extends EpgBaseDao {
	
	public void addUserInfo(String user_id,String top_address,String address) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("user_id", user_id);
		params.put("top_address", top_address);
		params.put("address", address);
		try {
				baseDao.getSqlMapClientTemplate().insert("insertUser", params);
		} catch (Exception dae) {
			 throw new DaoException(
	                    "add UserInfo by user_id " + user_id, dae);
		}finally{
			params.clear();
			params = null;
		}
	}
	public void updateUserInfo(String user_id,String top_address,String address) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("user_id", user_id);
		params.put("top_address", top_address);
		params.put("address", address);
		try {
				baseDao.getSqlMapClientTemplate().update("updateUser", params);
		} catch (Exception dae) {
			 throw new DaoException(
	                    "update UserInfo by user_id " + user_id, dae);
		}finally{
			params.clear();
			params = null;
		}
	}
	
	public DZDP_User getUserByUserId(String user_id) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("user_id", user_id);
		try {
			return (DZDP_User)baseDao.getSqlMapClientTemplate().queryForObject("getUserByUserId", params);
		} catch (Exception dae) {
			 throw new DaoException(
	                    "An exception produced  when searching User by user_id " + user_id, dae);
		}finally{
			params.clear();
			params = null;
		}
	}
}
