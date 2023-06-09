import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/logic/shop/handler.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultFormField({
  @required context,
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool showCursor = true,
  bool readOnly = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      showCursor: showCursor,
      readOnly: readOnly,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );
void showFlutterToast(String message, Color color, Toast toastLength) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

Widget gridProductBuilder(product, MainShopHandler mainShopHandler,
    {bool isOldPrice = true}) {
  return Container(
    color: Colors.white,
    child: Container(
      height: 175,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(product.image),
                width: 175,
                height: 175,
              ),
              if (isOldPrice)
                if (product.discount != 0)
                  Container(
                      color: Colors.red,
                      child: Text(
                        'DISCOUNT ${product.discount}%',
                        style: TextStyle(color: Colors.white),
                      )),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${product.price}",
                        style: TextStyle(fontSize: 16, color: defaultColor)),
                    SizedBox(
                      width: 10,
                    ),
                    if (isOldPrice)
                      if (product.discount != 0)
                        Text(
                          "${product.oldPrice}",
                          style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    SizedBox(
                      width: 5,
                    ),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor: mainShopHandler.favorites[product.id]
                          ? defaultColor
                          : Colors.grey,
                      child: IconButton(
                        icon: Icon(
                          mainShopHandler.favorites[product.id]
                              ? Icons.favorite
                              : Icons.favorite_outline_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          mainShopHandler.toggleProductFavorite(product.id);
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
/*
Widget buildArticleItem(article, context) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WebViewScreen(article['url']);
          },
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(
                    '${article['urlToImage'] ?? "https://i.imgur.com/JMR0LkP.png"}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "${article['title']}",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Text(
                    "${article['publishedAt']}",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget myDividor() {
  return Padding(
    padding: EdgeInsetsDirectional.only(start: 20),
    child: Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey[300],
    ),
  );
}

Widget articlesScreenBuilder(List list, context, {isSearch = false}) {
  return ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) {
      return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return buildArticleItem(list[index], context);
        },
        separatorBuilder: (context, index) {
          return myDividor();
        },
        itemCount: list.length,
      );
    },
    fallback: (context) {
      return isSearch
          ? Container()
          : Center(child: CircularProgressIndicator());
    },
  );
}
Widget buildTaskItem(Map model, context) {
  AppHandler appHandler = BlocProvider.of<AppHandler>(context);
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40.0,
          child: Text('${model['time']}'),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${model['date']}',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
        IconButton(
            onPressed: model['status'] != 'done'
                ? () {
                    appHandler.updatingDatabase('done', model['id']);
                  }
                : () {
                    appHandler.updatingDatabase('new', model['id']);
                  },
            icon: model['status'] != 'done'
                ? Icon(Icons.check_circle_outline_outlined)
                : Icon(Icons.restart_alt_rounded),
            color: Colors.green),
        IconButton(
          onPressed: () {
            appHandler.updatingDatabase('archived', model['id']);
          },
          icon: Icon(
            Icons.archive,
            color: model['status'] != 'archived' ? Colors.blue : Colors.grey,
          ),
        ),
        IconButton(
            onPressed: () {
              appHandler.deletingFromDatabase(model['id']);
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            )),
      ],
    ),
  );
}
Widget tasksBuilder(List tasks) {
  return ConditionalBuilder(
    condition: tasks.length > 0,
    builder: (context) {
      return ListView.separated(
          itemBuilder: (context, index) {
            return buildTaskItem(tasks[index], context);
          },
          separatorBuilder: (context, index) {
            return Padding(
              padding: EdgeInsetsDirectional.only(start: 20),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            );
          },
          itemCount: tasks.length);
    },
    fallback: (context) {
      return Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'OOPS!',
              style: TextStyle(
                  fontSize: 60,
                  color: Colors.red,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'There are no tasks here.',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      );
    },
  );
}
*/