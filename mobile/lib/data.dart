import 'package:flutter/material.dart';


class SliderModel{

  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath,this.title,this.desc});

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}


List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc(
      "Detect potholes,accidents,animal killings and much more..");
  sliderModel.setTitle("Detect");
  sliderModel.setImageAssetPath("images/detect.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc(
      "Report to the authorities directly so that these things don't go unnnotice");
  sliderModel.setTitle("Report..");
  sliderModel.setImageAssetPath("images/report.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("Get rewarded");
  sliderModel.setTitle("JAN SUVIDHA");
  sliderModel.setImageAssetPath("images/gift card.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}