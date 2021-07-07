<a href="https://yeslms.com/">
    <img src="./docs/media/mongo_peer.png" target="_blank" align="right" height="100"
    style="background-color:green;" />
</a>

## mongoDB PeerIslands
Flutter application to manage MongoDB Atlas resources.

<h2 align="center">Topics 📋</h2>

- [Preview 📱](#preview-)
- [Stack 🍀](#stack-)
- [Architecture 🧑🏽‍💻](#architecture-)
- [Source Tree 🌴](#source-tree-)
- [Tasks 😨](#tasks-)
- [How to Use 🤔](#how-to-use-)
- [How to Contribute 💪](#how-to-contribute-)

---

<h2 align="center">Preview 📱</h2>
   <p align="center">
      <img src="./docs/media/app.gif" width="400" alt="App Demo">
   </p>

 ---

<h2 align="center">Stack 🍀</h2>

- [flutter_bloc](https://pub.dev/packages/flutter_bloc) 
- [dartz](https://pub.dev/packages/dartz) 
- [fl_chart](https://pub.dev/packages/fl_chart)
- [flutter_sparkline](https://pub.dev/packages/flutter_sparkline)
- [flutter_staggered_grid_view](https://pub.dev/packages/flutter_staggered_grid_view)
- [flutter_login](https://pub.dev/packages/flutter_login)
- [flutter_svg](https://pub.dev/packages/flutter_svg)
- [get_it](https://pub.dev/packages/get_it)
- [cool_alert](https://pub.dev/packages/cool_alert)
- [easy_dynamic_theme](https://pub.dev/packages/easy_dynamic_theme)
- [eva_icons_flutter](https://pub.dev/packages/eva_icons_flutter)
- [dropdown_search](https://pub.dev/packages/dropdown_search)
- [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)
- [group_list_view](https://pub.dev/packages/group_list_view)
- [enum_to_string](https://pub.dev/packages/enum_to_string)
- [date_range_form_field](https://pub.dev/packages/date_range_form_field)
- [date_format](https://pub.dev/packages/date_format)
- [intl](https://pub.dev/packages/intl)
- [flutter_slidable](https://pub.dev/packages/flutter_slidable)
- [multi_select_flutter](https://pub.dev/packages/multi_select_flutter)
- [intl](https://pub.dev/packages/dio)
- [cupertino_icons](https://pub.dev/packages/cupertino_icons)

---

<h2 align="center">Architecture 🧑🏽‍💻</h2>
   <p align="center">
      <img src="./docs/media/mongo_app_arc.png" alt="App Architecture">
   </p>

---

<h2 align="center">Source Tree 🌴</h2>

```bash
├── lib
│   ├── core
│   │   ├── constants
|   |   │   ├── app_constants.dart --example
│   │   ├── entities
|   |   │   ├── shared_entity.dart --example
│   │   ├── error
|   |   │   ├── dio_exceptions.dart
|   |   │   ├── failures.dart
│   │   ├── http
|   |   │   ├── api_base_helper.dart --base class
│   │   ├── ioc
|   |   │   ├── injector_container.dart
│   │   ├── use_cases
|   |   │   ├── use_cases.dart --base class
│   │   ├── util
|   |   │   ├── common_functions.dart 
│   │   ├── widgets
|   |   │   ├── shared_button.dart --example
│   ├── features
│   │   ├── some_feature --example
|   │   │   ├── data
|   |   │   │   ├── datasources
|   |   |   │   │   ├── some_feature_cache_datasource.dart
|   |   |   │   │   ├── some_feature_remote_datasource.dart
|   |   │   │   ├── models
|   |   |   │   │   ├── some_feature_model.dart
|   |   │   │   ├── repositories
|   |   |   │   │   ├── some_feature_repository_impl.dart
|   │   │   ├── domain
|   |   │   │   ├── entities
|   |   |   │   │   ├── some_feature.dart
|   |   │   │   ├── enums
|   |   |   │   │   ├── some_feature_type_enum.dart
|   |   │   │   ├── repositories
|   |   |   │   │   ├── some_feature_repository.dart
|   |   │   │   ├── use_cases
|   |   |   │   │   ├── fetch_some_feature_data.dart
|   |   |   │   │   ├── add_some_feature.dart
|   │   │   ├── presentation
|   |   │   │   ├── bloc
|   |   |   │   │   ├── some_feature_bloc.dart
|   |   |   │   │   ├── some_feature_event.dart
|   |   |   │   │   ├── some_feature_state.dart
|   |   │   │   ├── pages
|   |   |   │   │   ├── some_feature_page.dart
|   |   │   │   ├── widgets
|   |   |   │   │   ├── specific_button.dart
```

---
<h2 align="center">Tasks 😨</h2>

- [x] homepage (feature)
- [x] database_access (feature)
- [x] network_access (feature)
- [x] metric_charts
- [ ] Switch between environments (dev/prod)
- [ ] Deploy

---

<h2 align="center">How to Use 🤔</h2>

   ```
   # Configure your environment. See details on: https://flutter.dev/docs/get-started/install
   
   # Clone this repository
   $ git clone https://github.com/PeerIslands/app-mongo-console.git

   # Enter in the directory
   $ cd app-mongo-console

   # Install dependencies
   $ flutter pub get

   # Run
   $ flutter run
   ```

---

<h2 align="center">How to Contribute 💪</h2>

   ```
   # Fork and clone the project
   $ git clone https://github.com/PeerIslands/app-mongo-console.git

   # Create a new branch with your changes
   $ git checkout -b my-feature

   # Commit your changes
   $ git commit -m "feature(scope): my message"

   # Push your changes
   $ git push origin my-feature
   ```

---
