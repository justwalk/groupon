package sitv.epg.business.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import sitv.epg.entity.business.DZDP_Comment;
import sitv.epg.entity.edit.EpgCategoryItem;
import chances.epg.exception.DaoException;
import chances.epg.ibtais.BaseDaoiBatis;

/**
 * 看吧数据访问类
 * 
 * @author zhangxs
 * 
 */
@Repository
@SuppressWarnings("unchecked")
public class DZDP_CommentService  extends EpgBaseDao {


	public DZDP_Comment getCommentdetailBydealId(String dealId) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("dealId", dealId);
		try {
			DZDP_Comment districtContent = (DZDP_Comment) baseDao
					.getSqlMapClientTemplate().queryForObject(
							"getGroupBuyItemDetail", paramMap);
			return districtContent;
		} catch (DataAccessException dae) {
			throw new DaoException(
					"An exception produced  when searching Comment by dealId: "
							+ dealId, dae);
		} finally {
			paramMap.clear();
			paramMap = null;
		}
	}
	
	public DZDP_Comment getCommentContent(String address,String firstMenuName) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("addressName", address);
		paramMap.put("firstMenuName", firstMenuName);
		try {
			DZDP_Comment districtContent = (DZDP_Comment) baseDao
					.getSqlMapClientTemplate().queryForObject(
							"getCommentByPage", paramMap);
			return districtContent;
		} catch (DataAccessException dae) {
			throw new DaoException(
					"An exception produced  when searching Comment by address: "
							+ address, dae);
		} finally {
			paramMap.clear();
			paramMap = null;
		}
	}

	public List<DZDP_Comment> getCommentContents(String childCategoryId,String categoryId,String address,String top_address,String recommend,String orderBy,int startRow,int maxRow) {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			if(!"".equals(childCategoryId)&&childCategoryId!=null){
				paramMap.put("childCategoryId", childCategoryId);
			}
			if(!"".equals(categoryId)&&categoryId!=null){
				paramMap.put("categoryId", categoryId);
			}
			if(!"".equals(address)&&address!=null){
				paramMap.put("address", address);
			}
			if(!"".equals(top_address)&&top_address!=null){
				paramMap.put("top_address", top_address);
			}
			if(!"".equals(recommend)&&recommend!=null){
				paramMap.put("recommend", recommend);
			}
	        try {
	        	if("purchase_count".equals(orderBy)){
					return baseDao.getSqlMapClient().queryForList("getCommentByPageOrderByPurchaseCount", paramMap,startRow, maxRow);
				}else if("publish_date".equals(orderBy)){
					return baseDao.getSqlMapClient().queryForList("getCommentByPageOrderByPublishDate", paramMap,startRow, maxRow);
				}else if("discount_rate".equals(orderBy)){
					return baseDao.getSqlMapClient().queryForList("getCommentByPageOrderByDiscountRate", paramMap,startRow, maxRow);
				}
	        } catch (DataAccessException dae) {
	            throw new DaoException(
	                    "An exception produced  when searching Comment by address " + address, dae);
	        } catch (SQLException ex) {
	            throw new DaoException("An exception produced  when searching  Comment by address " + address, ex);
	        }finally{
	        	paramMap.clear();
	        	paramMap = null;
	        }
			return null;
	}

}
