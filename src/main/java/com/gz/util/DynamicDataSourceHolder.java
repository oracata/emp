package com.gz.util;

public class DynamicDataSourceHolder {
    //创建线程变量 把数据源标识保存在线程变量，免费数据源切换时产生混乱
    private  static  final ThreadLocal<String> THREAD_DATA_SOURCE=new ThreadLocal<String>();
    public static String getDataSource()
    {
        return THREAD_DATA_SOURCE.get();
    }
    public static void   setDataSource(String dataSource)
    {
        THREAD_DATA_SOURCE.set(dataSource);
    }

    public static void clearDataSource()
    {
        THREAD_DATA_SOURCE.remove();
    }
}
