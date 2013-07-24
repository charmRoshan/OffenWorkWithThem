百度地图IphoneSDK2.0.1共有10个Demo,每个Demo的说明如下：

-------------------------------------------------------------------------------------

一、
Demo名称：MapViewDemo
文件名：  MapViewDemoViewController.mm

简介：创建一张百度地图并管理地图的生命周期
详述：
（1）创建一张最简单的百度地图，显示路况、卫星图等；
（2）管理地图的生命周期，具体请参看代码部分的相关注释；
-------------------------------------------------------------------------------------

二、
Demo名称：LocationDemo
文件名：  LocationDemoViewController.m

简介：介绍定位功能的基本用法
详述：
（1）获取我的位置，并在地图上显示的演示功能；开发者可以自己修改icon_center_point.png 
		和icon_center_point@2x.png资源修改默认的定位图标
-------------------------------------------------------------------------------------

三、
Demo名称：AnnotationDmeo
文件名：  AnnotationDemoViewController.m

简介：介绍如何添加annotation
详述：
（1）通过BMKMapView的addAnnotation接口添加一个标注；
（2）开发者可以实现BMKMapViewDelegate中mapView:viewForAnnotation；接口，提供要添加到
		地图中的标注的BMKAnnotationView，开发者可以扩展此类丰富更多的功能。
（3）注意：addAnnotation的调用必须在viewDidAppear中或者之后的时间添加，在viewDidAppear
		生命周期之前调用，会有问题。
-------------------------------------------------------------------------------------

四、
Demo名称：OverlayDemo
文件名：  OverlayDemoViewController.m

简介：介绍如何添加overlay
详述：
（1）通过BMKMapView的addOverlay接口添加一个覆盖物；
（2）开发者可以实现BMKMapViewDelegate中mapView:viewForOverlay；接口，提供要添加到
		地图中的标注的BMKOverlayView，开发者可以扩展此类丰富更多的功能。
-------------------------------------------------------------------------------------

五、
Demo名称：PoiSearchDemo
文件名：  PoiSearchDemoViewController.m

简介：介绍BMKSearch类相关检索功能
详述：
（1）介绍poi的检索功能，以及数据的回调。通过addAnnotation标注这些点；
-------------------------------------------------------------------------------------

六、
Demo名称：RouteSearchDemo
文件名：  RouteSearchDemoViewController.m

简介：介绍路线检索相关功能
详述：
（1）支持步行、驾车、公交检索，以及如何在地图上显示；
-------------------------------------------------------------------------------------

七、
Demo名称：ReverseGeoCodeDemo
文件名：  GeoCodeDemoViewController.m

简介：介绍地址信息与坐标之间的相互转换
详述：
（1）正向地理编码：将地址信息转换为经纬度坐标；
（2）反向地理编码：将经纬度坐标转换为地址信息；
-------------------------------------------------------------------------------------

八、
Demo名称：OfflineDemo
文件名：  OfflineDemoViewController.m

简介：介绍如何下载和使用离线地图
详述：
（1）可以检索、下载、删除、查看离线地图；
（2）扫描离线地图：
SDK支持导入离线包，将从官方渠道下载的离线包解压，把*.zip文件通过91助手拷入Document目录下进行导入；
-------------------------------------------------------------------------------------

九、
Demo名称：BusLineSearchDemo
文件名：  BusLineSearchViewController.m

简介：介绍查询公交线路功能
-------------------------------------------------------------------------------------

十、
Demo名称：CustomOverlayDemo
文件名：	CustomOverlayDemoViewController.m

简介：演示如何自定义Overlay
详述：
（1）介绍如何自定义Overlay绘制各种自定义图形
-------------------------------------------------------------------------------------
