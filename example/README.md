# Example App (LIVE edition)

Runnable catalog for [flutter_helper_kit](../README.md). **LIVE** keeps all original sandbox code plus the full kit demo catalog.

## Run

```bash
cd example
flutter run
```

## Structure

```
lib/
├── main.dart                 # ScreenUtilInit + CatalogHome
├── catalog/
│   ├── example_catalog.dart  # 83+ demos (kit + live sandbox)
│   └── catalog_home.dart     # Searchable home
├── examples/
│   ├── extensions/           # String, bool, widget, map, …
│   ├── widgets/              # SliderButton, GenericPickerSheet, …
│   ├── utils/                # printf, decorations, HTTP logs, …
│   ├── live/                 # LIVE-only preserved sandboxes
│   └── …
├── home.dart                 # Preserved — wired via Live Sandbox catalog
├── pagination_list_view_example.dart
├── widgets_example/my_custom_text_field.dart
└── new_widgets/app_text_field.dart
```

## Live Sandbox category

These demos map to **example-only** code that was in the live project before the kit sync:

| Demo | File |
|------|------|
| Home Screen Sandbox | `example/lib/home.dart` |
| MyCustomTextField | `example/lib/widgets_example/my_custom_text_field.dart` |
| Pagination Standalone | `example/lib/pagination_list_view_example.dart` |

Nothing was removed — all live files remain on disk and in the catalog.

## Add a new demo

1. Create a builder under `lib/examples/<category>/`.
2. Register in `lib/catalog/example_catalog.dart`.
3. Export new APIs from `../lib/flutter_helper_kit.dart` if needed.

Full package docs: [../README.md](../README.md)
