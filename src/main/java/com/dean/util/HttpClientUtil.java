package com.dean.util;

import java.io.IOException;

import org.apache.commons.httpclient.DefaultHttpMethodRetryHandler;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.log4j.Logger;

/**
 * 提供http操作
 * @author dongxu
 *
 */
public class HttpClientUtil {
	private static Logger log = Logger.getLogger(HttpClientUtil.class);  
	/**
	   httpClient的get请求方式2
	 * @return
	 * @throws Exception
	 */
	public static String doGet(String url, String charset)	throws Exception {
		/*
		 * 使用 GetMethod 来访问一个 URL 对应的网页,实现步骤: 1:生成一个 HttpClinet 对象并设置相应的参数。
		 * 2:生成一个 GetMethod 对象并设置响应的参数。 3:用 HttpClinet 生成的对象来执行 GetMethod 生成的Get
		 * 方法。 4:处理响应状态码。 5:若响应正常，处理 HTTP 响应内容。 6:释放连接。
		 */
		/* 1 生成 HttpClinet 对象并设置参数 */
		HttpClient httpClient = new HttpClient();
		// 设置 Http 连接超时为5秒
		httpClient.getHttpConnectionManager().getParams().setConnectionTimeout(5000);
		/* 2 生成 GetMethod 对象并设置参数 */
		GetMethod getMethod = new GetMethod(url);
		// 设置 get 请求超时为 5 秒
		getMethod.getParams().setParameter(HttpMethodParams.SO_TIMEOUT, 5000);
		// 设置请求重试处理，用的是默认的重试处理：请求三次
		getMethod.getParams().setParameter(HttpMethodParams.RETRY_HANDLER,	new DefaultHttpMethodRetryHandler());
		String response = "";
		/* 3 执行 HTTP GET 请求 */
		try {
			int statusCode = httpClient.executeMethod(getMethod);
			/* 4 判断访问的状态码 */
			if (statusCode != HttpStatus.SC_OK) {
				log.error("请求出错: "+ getMethod.getStatusLine());
			}
			/* 5 处理 HTTP 响应内容 */
			// HTTP响应头部信息，这里简单打印
			/*Header[] headers = getMethod.getResponseHeaders();
			for (Header h : headers)
				System.out.println(h.getName() + "------------ " + h.getValue());*/
			// 读取 HTTP 响应内容，这里简单打印网页内容
			byte[] responseBody = getMethod.getResponseBody();// 读取为字节数组
			response = new String(responseBody, charset);
			//System.out.println("----------response:" + response);
			// 读取为 InputStream，在网页内容数据量大时候推荐使用
			// InputStream response = getMethod.getResponseBodyAsStream();
		} catch (HttpException e) {
			// 发生致命的异常，可能是协议不对或者返回的内容有问题
			log.error("请检查输入的URL!");
		} catch (IOException e) {
			// 发生网络异常
			log.error("发生网络异常!");
		} finally {
			/* 6 .释放连接 */
			getMethod.releaseConnection();
		}
		return response;
	}

	public static String doPost(String url,String body,String charset){  
		HttpClient client = new HttpClient();     
		//设置代理服务器地址和端口       
		//client.getHostConfiguration().setProxy("proxy_host_addr",proxy_port);  
		//使用GET方法，如果服务器需要通过HTTPS连接，那只需要将下面URL中的http换成https  
		// HttpMethod method = new GetMethod("http://10.1.14.20:8088/workflowController/service/todo/addTask");   
		//使用POST方法  
		PostMethod method = new PostMethod(url);   

		((PostMethod) method).setRequestBody(body);

		HttpMethodParams param = method.getParams();  
		param.setContentCharset(charset);  
		String str = null;
		try {
			int statusCode = client.executeMethod(method);
			if (statusCode != HttpStatus.SC_OK) {
				log.error("请求出错: "+ method.getStatusLine());
			}
			str = method.getResponseBodyAsString();
		} catch (HttpException e) {
			log.error("请检查输入的URL!");
		} catch (IOException e) {
			log.error("发生网络异常!");
		}finally{
			method.releaseConnection();  
		}
		log.info(str.toString());
		//释放连接  
		return str;

	}  
}
