package com.afunms.polling.snmp.system;

/*
 * @author yangjun@dhcc.com.cn
 *
 */

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Hashtable;
import java.util.Vector;

import com.afunms.common.util.ShareData;
import com.afunms.common.util.SysLogger;
import com.afunms.indicators.model.NodeGatherIndicators;
import com.afunms.monitor.executor.base.SnmpMonitor;
import com.afunms.monitor.item.base.MonitoredItem;
import com.afunms.polling.PollingEngine;
import com.afunms.polling.base.Node;
import com.afunms.polling.node.UPSNode;
import com.afunms.polling.om.Systemcollectdata;
import com.afunms.polling.snmp.SnmpMibConstants;
import com.afunms.topology.model.HostNode;
import com.gatherResulttosql.NetHostDatatempSystemRttosql;


/**
 * @author Administrator
 *
 * To change the template for this generated type comment go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
public class EmsSystemSnmp extends SnmpMonitor {
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	/**
	 * 
	 */
	public EmsSystemSnmp() {
	}

	   public void collectData(Node node,MonitoredItem item){
		   
	   }
	   public void collectData(HostNode node){
		   
	   }
	/* (non-Javadoc)
	 * @see com.dhcc.webnms.host.snmp.AbstractSnmp#collectData()
	 */
	public Hashtable collect_Data(NodeGatherIndicators alarmIndicatorsNode) {
		Hashtable returnHash=new Hashtable();
		Vector systemVector=new Vector();
		UPSNode node = (UPSNode)PollingEngine.getInstance().getUpsByID(Integer.parseInt(alarmIndicatorsNode.getNodeid()));
		if(node == null)return null;
		Systemcollectdata systemdata=null;
		Calendar date=Calendar.getInstance();
		try{
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			com.afunms.polling.base.Node snmpnode = (com.afunms.polling.base.Node)PollingEngine.getInstance().getUpsByIP(node.getIpAddress());
			Date cc = date.getTime();
			String time = sdf.format(cc);
			snmpnode.setLastTime(time);
		}catch(Exception e){
			  e.printStackTrace();
		}
		try{
//		    final String[] desc=SnmpMibConstants.UpsMibSystemDesc;
//			final String[] chname=SnmpMibConstants.UpsMibSystemChname;
//			  String[] oids =                
//				  new String[] {               
//					"1.3.6.1.4.1.13400.2.1.2.1.1.1" ,//UPS型号
//					"1.3.6.1.4.1.13400.2.1.2.1.1.2" ,//UPS名称
//					"1.3.6.1.4.1.13400.2.1.2.1.2.1" ,//固件版本
//					"1.3.6.1.4.1.13400.2.1.2.1.2.2" ,//出厂日期
//					"1.3.6.1.4.1.13400.2.1.2.1.2.3" ,//序列号
//					"1.3.6.1.4.1.13400.2.1.2.1.2.4" //生产厂家
//				  };
			final String[] desc=SnmpMibConstants.NetWorkMibSystemDesc;
			final String[] chname=SnmpMibConstants.NetWorkMibSystemChname;
					  String[] oids =                
						  new String[] {               
							"1.3.6.1.2.1.1.1" ,//设备描述
							"1.3.6.1.2.1.1.3" ,//运行时间
							"1.3.6.1.2.1.1.4" ,//联系人
							"1.3.6.1.2.1.1.5" ,//设备名称
							"1.3.6.1.2.1.1.6" ,//设备位置
							"1.3.6.1.2.1.1.7" //服务类型
							
							  };		  
			String[][] valueArray = null;   	  
			try {
				valueArray = snmp.getTableData(node.getIpAddress(),node.getCommunity(),oids);
			} catch(Exception e){
				valueArray = null;
				e.printStackTrace();
			}
			if(valueArray != null){
		   	    for(int i=0;i<valueArray.length;i++){
		   		    for(int j=0;j<6;j++){
			   			systemdata=new Systemcollectdata();
						systemdata.setIpaddress(node.getIpAddress());
						systemdata.setCollecttime(date);
						systemdata.setCategory("System");
						systemdata.setEntity(desc[j]);
						systemdata.setSubentity(desc[j]);
						systemdata.setChname(chname[j]);
						systemdata.setRestype("static");
						systemdata.setUnit("");
						String value = valueArray[i][j];
						SysLogger.info("******************EmsSystemSnmp:value====="+value);
						systemdata.setThevalue(value);
						systemVector.addElement(systemdata);
		   		   }
		   	   }
		    }
		} catch(Exception e){
			  e.printStackTrace();
		}
		
//		Hashtable ipAllData = (Hashtable)ShareData.getSharedata().get(node.getIpAddress());
//		if(ipAllData == null)ipAllData = new Hashtable();
//		ipAllData.put("system",systemVector);
//	    ShareData.getSharedata().put(node.getIpAddress(), ipAllData);
//	    returnHash.put("system", systemVector);
	    
		if (!(ShareData.getSharedata().containsKey(node.getIpAddress()))) {
			Hashtable ipAllData = new Hashtable();
			if (ipAllData == null) ipAllData = new Hashtable();
			if (systemVector != null && systemVector.size() > 0) ipAllData.put("system", systemVector);
				ShareData.getSharedata().put(node.getIpAddress(), ipAllData);
		} else{
			if (systemVector != null && systemVector.size() > 0) ((Hashtable) ShareData.getSharedata().get(node.getIpAddress())) .put("system", systemVector);
		}	
		returnHash.put("system",systemVector);
//	    ipAllData=null;
	    systemVector=null;
	   
	    
	    //NetHostDatatempSystemRttosql tosql=new NetHostDatatempSystemRttosql();
	   // tosql.CreateResultTosql(returnHash, node);
	    //tosql.CreateResultTosql(returnHash, node);
	    
	    
	    
	    return returnHash;
	}
}





