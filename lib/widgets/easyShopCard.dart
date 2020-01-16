import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/company.dart';
import 'package:flutter_ecommerce/services/firestore_company_service.dart';
import 'package:flutter_ecommerce/widgets/starRating.dart';

class EasyShopCard extends StatefulWidget {
  final String product_id;
  final String image;
  final String itemName;
  final String price;
  final String prePrice;
  final String badge;
  final Alignment badgeAlignment;
  final double rating;
  final double height;
  final double imageHeight;
  final Function onTap;
  final String supplierName;

  final String button;
  final Function btnOnPressed;
  final Function favoriteOnTap;
  final bool favorited;

  final Color badgeColor;
  final Color badgeBgColor;
  final Color itemNameColor;
  final Color priceColor;
  final Color prePriceColor;
  final Color ratingColor;
  final Color backgroundColor;
  final Color buttonColor;
  final Color buttonTextColor;
  final Color favoritedColor;

  const EasyShopCard({
    Key key,
    this.itemName,
    this.product_id,
    @required this.image,
    this.prePrice,
    this.price,
    this.supplierName,
    this.rating,
    this.badge,
    this.badgeAlignment,
    this.badgeColor,
    this.badgeBgColor,
    this.itemNameColor,
    this.prePriceColor,
    this.priceColor,
    this.backgroundColor,
    this.button,
    @required this.height,
    this.imageHeight,
    this.onTap,
    this.btnOnPressed,
    this.favoriteOnTap,
    this.favorited,
    this.ratingColor,
    this.buttonColor,
    this.buttonTextColor,
    this.favoritedColor,
  }) : super(key: key);

  _EasyShopCardState createState() => _EasyShopCardState();
}

class _EasyShopCardState extends State<EasyShopCard> {
  String supplierName = "";

  @override
  Widget build(BuildContext context) {
    FirebaseFirestoreServiceCompany cdb = FirebaseFirestoreServiceCompany();
    cdb.getCompanyByID(widget.supplierName).listen((onData) {
      Company company = Company.fromMap(onData.documents[0].data);
      setState(() {
        supplierName = company.companyName;
      });
    });
    return InkWell(
      onTap: widget.onTap,
      child: Card(
        color: (widget.backgroundColor != null)
            ? widget.backgroundColor
            : Colors.white,
        child: Container(
          alignment: Alignment.topCenter,
          height: widget.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
                child: Stack(
                  alignment: (widget.badgeAlignment != null)
                      ? widget.badgeAlignment
                      : Alignment.topRight,
                  children: <Widget>[
                    // Image(
                    //   width: MediaQuery.of(context).size.width * 0.5,
                    //   height: this.imageHeight,
                    //   fit: BoxFit.fill,
                    //   image: this.image,
                    // ),
                    Hero(
                      tag: "product_${widget.product_id}L",
                      child: CachedNetworkImage(
                        imageUrl: widget.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: widget.imageHeight,
                      ),
                    ),
                    (widget.badge != null)
                        ? Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (widget.badgeBgColor != null)
                                    ? widget.badgeBgColor
                                    : Colors.red),
                            alignment: Alignment.center,
                            child: Text(
                              widget.badge,
                              style: TextStyle(
                                  color: (widget.badgeColor != null)
                                      ? widget.badgeColor
                                      : Colors.white),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 0.0),
                child: Text(
                  widget.itemName,
                  style: TextStyle(
                      color: (widget.itemNameColor != null)
                          ? widget.itemNameColor
                          : Colors.grey[800]),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '\$' + widget.prePrice,
                        style: TextStyle(
                          color: (widget.prePriceColor != null)
                              ? widget.prePriceColor
                              : Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      TextSpan(
                        text: " \$" + widget.price,
                        style: TextStyle(
                            color: (widget.priceColor != null)
                                ? widget.priceColor
                                : Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'From' + supplierName == null ? '' : supplierName,
                        style: TextStyle(
                          color: (widget.prePriceColor != null)
                              ? widget.prePriceColor
                              : Colors.blue,
                          // decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: StarRating(
                  rating: widget.rating,
                  color: (widget.ratingColor != null)
                      ? widget.ratingColor
                      : Colors.orange[400],
                  onRatingChanged: (rating) {},
                ),
              ),
              (widget.button != null)
                  ? Container(
                      height: 30.0,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: FlatButton(
                              color: widget.buttonColor,
                              onPressed: widget.btnOnPressed,
                              child: Text(
                                widget.button,
                                style: TextStyle(
                                    color: (widget.buttonTextColor != null)
                                        ? widget.buttonTextColor
                                        : Colors.black),
                              ),
                            ),
                          ),
                          (widget.favorited != null)
                              ? InkWell(
                                  onTap: widget.favoriteOnTap,
                                  child: Container(
                                    height: 30.0,
                                    width: 30.0,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(left: 5.0),
                                    child: Icon(
                                      (widget.favorited)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: (widget.favoritedColor != null)
                                          ? widget.favoritedColor
                                          : Colors.black,
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
