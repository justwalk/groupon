package sitv.epg.business.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import sitv.epg.entity.business.DZDP_Address;
import sitv.epg.entity.business.DZDP_Category;
import chances.epg.exception.DaoException;

/**
 * 看吧数据访问类
 * 
 * @author zhangxs
 * 
 */
@Repository
public class businessAreaService extends EpgBaseDao {
	
	public DZDP_Address getBusinessAreaByCode(String code) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pid", code);
		try {
			DZDP_Address epgBusinessArea = (DZDP_Address) baseDao
					.getSqlMapClientTemplate().queryForObject(
							"getBusinessAreaByPid", params);
			return epgBusinessArea;
		} catch (DataAccessException dae) {
			throw new DaoException(
					"An exception produced  when searching district by pid: "
							+ code, dae);
		}finally{
			params.clear();
			params = null;
		}
	}


}
