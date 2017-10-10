package com.wbdp.wx.utils.http;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Random;

import javax.net.ssl.SSLException;

import org.apache.log4j.Logger;

public class Face {
	
	//应用KEY
	private final static String API_KEY="L5TZtFej6w7ld_XV4hADv3-tVUSvLIW5";
	
	//应用SECRET
	private final static String API_SECRET="sImsgadoVfwXU-dBD230yRPFG5kLGpnv";
	
	//Face++人脸对比接口
	private final static String URL_COMPARE="https://api-cn.faceplusplus.com/facepp/v3/compare";
	
    //Log
	private static Logger logger=Logger.getLogger(Face.class);
	
	/**
	 * <p>方法名: faceCompare</p> 
	 * <p>方法描述: Face++人脸识别 </p>
	 * <p>入参描述: 入参两张照片均为URL地址,不分先后顺序</p>
	 * <p>回调描述: {"faces1": [{"face_rectangle": {"width": 129, "top": 201, "left": 378, "height": 129}, "face_token": "99b8b316006b5f251d6cd0ae394c8c66"}], "faces2": [{"face_rectangle": {"width": 129, "top": 201, "left": 378, "height": 129}, "face_token": "f54e2a9b26454935545d7a028284be0a"}], "time_used": 1431, "thresholds": {"1e-3": 62.327, "1e-5": 73.975, "1e-4": 69.101}, "confidence": 97.389, "image_id2": "ZN2tujOp+U1ml+J8EiHDZA==", "image_id1": "ZN2tujOp+U1ml+J8EiHDZA==", "request_id": "1503472050,781b67cc-a8ff-420c-a2e0-619aafa317c9"}</p>
	 * <p>创建人:wisedata004  </p>
	 * <p>创建时间: 2017年8月23日 </p>
	 */
   public static String faceCompare(String img_url1,String img_url2){	

//************采用文件比对形式**********	  
//      File file1 = new File("e:/jiang-cam.jpg");
//		byte[] buff1 = getBytesFromFile(file1);
//		File file2 = new File("e:/jiang.jpg");
//		byte[] buff2 = getBytesFromFile(file2);
//    HashMap<String, byte[]> byteMap = new HashMap<>();        
//    byteMap.put("image_file1", buff1);
//    byteMap.put("image_file2", buff2);
	  
	    //封装请求数据
        HashMap<String, String> map = new HashMap<>();
        map.put("api_key", API_KEY);
        map.put("api_secret", API_SECRET);
        map.put("image_url1", img_url1);
        map.put("image_url2", img_url2);
        try{
            byte[] bacd = post(URL_COMPARE, map, null);
            String str = new String(bacd);
            return str;
        }catch (Exception e) {
        	e.printStackTrace();
        	logger.error("Face++人脸识别异常:"+e);
		}
        return null;
	}
	

    //连接超时时间和读取超时时间设置
	private final static int CONNECT_TIME_OUT = 30000;
    private final static int READ_OUT_TIME = 50000;
    private static String boundaryString = getBoundary();
    
    //处理请求
    protected static byte[] post(String url, HashMap<String, String> map, HashMap<String, String> fileMap) throws Exception {
        HttpURLConnection conne;
        URL url1 = new URL(url);
        conne = (HttpURLConnection) url1.openConnection();
        conne.setDoOutput(true);
        conne.setUseCaches(false);
        conne.setRequestMethod("POST");
        conne.setConnectTimeout(CONNECT_TIME_OUT);
        conne.setReadTimeout(READ_OUT_TIME);
        conne.setRequestProperty("accept", "*/*");
        conne.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundaryString);
        conne.setRequestProperty("connection", "Keep-Alive");
        conne.setRequestProperty("user-agent", "Mozilla/4.0 (compatible;MSIE 6.0;Windows NT 5.1;SV1)");
        DataOutputStream obos = new DataOutputStream(conne.getOutputStream());
        Iterator iter = map.entrySet().iterator();
        while(iter.hasNext()){
            Map.Entry<String, String> entry = (Map.Entry) iter.next();
            String key = entry.getKey();
            String value = entry.getValue();
            obos.writeBytes("--" + boundaryString + "\r\n");
            obos.writeBytes("Content-Disposition: form-data; name=\"" + key
                    + "\"\r\n");
            obos.writeBytes("\r\n");
            obos.writeBytes(value + "\r\n");
        }
        if(fileMap != null && fileMap.size() > 0){
            Iterator fileIter = fileMap.entrySet().iterator();
            while(fileIter.hasNext()){
                Map.Entry<String, String> fileEntry = (Map.Entry<String, String>) fileIter.next();
                obos.writeBytes("--" + boundaryString + "\r\n");
                obos.writeBytes("Content-Disposition: form-data; name=\"" + fileEntry.getKey()
                        + "\"; filename=\"" + encode(" ") + "\"\r\n");
                obos.writeBytes("\r\n");
                obos.write(fileEntry.getValue().getBytes());
                obos.writeBytes("\r\n");
            }
        }
        obos.writeBytes("--" + boundaryString + "--" + "\r\n");
        obos.writeBytes("\r\n");
        obos.flush();
        obos.close();
        InputStream ins = null;
        int code = conne.getResponseCode();
        try{
            if(code == 200){
                ins = conne.getInputStream();
            }else{
                ins = conne.getErrorStream();
            }
        }catch (SSLException e){
            e.printStackTrace();
            return new byte[0];
        }
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        byte[] buff = new byte[4096];
        int len;
        while((len = ins.read(buff)) != -1){
            baos.write(buff, 0, len);
        }
        byte[] bytes = baos.toByteArray();
        ins.close();
        return bytes;
    }
    private static String getBoundary() {
        StringBuilder sb = new StringBuilder();
        Random random = new Random();
        for(int i = 0; i < 32; ++i) {
            sb.append("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_-".charAt(random.nextInt("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_".length())));
        }
        return sb.toString();
    }
    private static String encode(String value) throws Exception{
        return URLEncoder.encode(value, "UTF-8");
    }
    
    public static byte[] getBytesFromFile(File f) {
        if (f == null) {
            return null;
        }
        try {
            FileInputStream stream = new FileInputStream(f);
            ByteArrayOutputStream out = new ByteArrayOutputStream(1000);
            byte[] b = new byte[1000];
            int n;
            while ((n = stream.read(b)) != -1)
                out.write(b, 0, n);
            stream.close();
            out.close();
            return out.toByteArray();
        } catch (IOException e) {
        }
        return null;
    }
    
}
