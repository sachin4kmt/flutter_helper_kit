import 'package:flutter/material.dart';

part 'generic_item.dart';

/// Material bottom-sheet picker for single or multi-select dropdown lists.
class GenericPickerSheet<T extends DropdownItem> extends StatefulWidget {
  const GenericPickerSheet({
    super.key,
    required this.items,
    required this.initialSelected,
    required this.multiSelect,
    this.canUnselectRadio = false,
    this.onDonePressed,
    this.emptyMessage = 'No items available',
    this.singleSelectTitle = 'Select',
    this.doneLabel = 'Done',
    this.selectAllLabel = 'Select All',
    this.unselectAllLabel = 'Unselect All',
  });

  final List<T> items;
  final List<T> initialSelected;
  final bool multiSelect;
  final bool canUnselectRadio;
  final VoidCallback? onDonePressed;
  final String emptyMessage;
  final String singleSelectTitle;
  final String doneLabel;
  final String selectAllLabel;
  final String unselectAllLabel;

  /// Opens a single-select picker and returns the chosen item.
  ///
  /// Returns [initialSelected] if the sheet is dismissed without tapping Done.
  static Future<T?> singleSelection<T extends DropdownItem>({
    required BuildContext context,
    required List<T> items,
    T? initialSelected,
    bool canUnselect = false,
    String emptyMessage = 'No items available',
    String singleSelectTitle = 'Select',
    String doneLabel = 'Done',
  }) async {
    var donePressed = false;

    final result = await showModalBottomSheet<T?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => GenericPickerSheet<T>(
        items: items,
        initialSelected: initialSelected != null ? [initialSelected] : [],
        multiSelect: false,
        canUnselectRadio: canUnselect,
        emptyMessage: emptyMessage,
        singleSelectTitle: singleSelectTitle,
        doneLabel: doneLabel,
        onDonePressed: () => donePressed = true,
      ),
    );

    if (!donePressed) return initialSelected;
    return result;
  }

  /// Opens a multi-select picker and returns the chosen items.
  ///
  /// Returns `null` if the sheet is dismissed without tapping Done.
  static Future<List<T>?> multiSelection<T extends DropdownItem>({
    required BuildContext context,
    required List<T> items,
    required List<T> initialSelected,
    String emptyMessage = 'No items available',
    String doneLabel = 'Done',
    String selectAllLabel = 'Select All',
    String unselectAllLabel = 'Unselect All',
  }) async {
    var donePressed = false;

    final result = await showModalBottomSheet<List<T>?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => GenericPickerSheet<T>(
        items: items,
        initialSelected: initialSelected,
        multiSelect: true,
        emptyMessage: emptyMessage,
        doneLabel: doneLabel,
        selectAllLabel: selectAllLabel,
        unselectAllLabel: unselectAllLabel,
        onDonePressed: () => donePressed = true,
      ),
    );

    if (!donePressed) return null;
    return result;
  }

  @override
  State<GenericPickerSheet<T>> createState() => _GenericPickerSheetState<T>();
}

class _GenericPickerSheetState<T extends DropdownItem>
    extends State<GenericPickerSheet<T>> {
  late T? _singleSelected;
  late final Set<T> _multiSelected;

  @override
  void initState() {
    super.initState();
    _singleSelected =
        widget.initialSelected.isNotEmpty ? widget.initialSelected.first : null;
    _multiSelected = <T>{...widget.initialSelected};
  }

  void _handleDone() {
    widget.onDonePressed?.call();
    if (!mounted) return;
    if (widget.multiSelect) {
      Navigator.pop(context, _multiSelected.toList());
    } else {
      Navigator.pop(context, _singleSelected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildSheet(context, List<T>.from(widget.items));
  }

  Widget _buildSheet(BuildContext context, List<T> items) {
    final theme = Theme.of(context);
    final maxHeight = MediaQuery.sizeOf(context).height * 0.7;
    final isAllSelected = items.isNotEmpty && _multiSelected.containsAll(items);

    return SafeArea(
      bottom: false,
      child: Material(
        color: theme.colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.multiSelect)
                    TextButton(
                      onPressed: items.isEmpty
                          ? null
                          : () {
                              setState(() {
                                if (isAllSelected) {
                                  _multiSelected.clear();
                                } else {
                                  _multiSelected
                                    ..clear()
                                    ..addAll(items);
                                }
                              });
                            },
                      child: Text(
                        isAllSelected
                            ? widget.unselectAllLabel
                            : widget.selectAllLabel,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        widget.singleSelectTitle,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  TextButton(
                    onPressed: _handleDone,
                    child: Text(
                      widget.doneLabel,
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 0),
              Flexible(
                child: items.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            widget.emptyMessage,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      )
                    : widget.multiSelect
                        ? ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(16),
                            itemCount: items.length,
                            itemBuilder: (_, index) {
                              final item = items[index];
                              final isChecked = _multiSelected.contains(item);

                              return CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                value: isChecked,
                                onChanged: (_) {
                                  setState(() {
                                    if (isChecked) {
                                      _multiSelected.remove(item);
                                    } else {
                                      _multiSelected.add(item);
                                    }
                                  });
                                },
                                title: Text(item.getLabel()),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                visualDensity: VisualDensity.compact,
                                dense: true,
                              );
                            },
                          )
                        : RadioGroup<T>(
                            groupValue: _singleSelected,
                            onChanged: (val) {
                              setState(() => _singleSelected = val);
                            },
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(16),
                              itemCount: items.length,
                              itemBuilder: (_, index) {
                                final item = items[index];
                                return RadioListTile<T>(
                                  value: item,
                                  title: Text(item.getLabel()),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  visualDensity: VisualDensity.compact,
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  toggleable: widget.canUnselectRadio,
                                );
                              },
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
