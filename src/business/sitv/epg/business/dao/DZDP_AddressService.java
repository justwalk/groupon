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
import chances.epg.exception.DaoException;

/**
 * 看吧数据访问类
 * 
 * @author zhangxs
 * 
 */
@Repository
public class DZDP_AddressService extends EpgBaseDao {
	
	public List<DZDP_Address> getAddressByPid(String pid) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pid", pid);
		try {
			if("0".equals(pid)){
				return baseDao.getSqlMapClient().queryForList("getAllAddress", params);
			}else{
				return baseDao.getSqlMapClient().queryForList("getAddressByPid", params);
			}
		} catch (SQLException dae) {
			 throw new DaoException(
	                    "An exception produced  when searching Comment by pid " + pid, dae);
		}finally{
			params.clear();
			params = null;
		}
	}
}
