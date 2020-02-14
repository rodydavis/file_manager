import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // test('shortcuts work', () {
  //   var keyBinding = ShortcutKeyBinding(
  //     [
  //       Shortcut(
  //         ShortcutAction.copy,
  //         [
  //           ShortcutKey.systemCmd,
  //           ShortcutKey.c,
  //         ],
  //       ),
  //       Shortcut(
  //         ShortcutAction.paste,
  //         [
  //           ShortcutKey.systemCmd,
  //           ShortcutKey.v,
  //         ],
  //       ),
  //       Shortcut(
  //         ShortcutAction.cut,
  //         [
  //           ShortcutKey.systemCmd,
  //           ShortcutKey.x,
  //         ],
  //       ),
  //       Shortcut(
  //         ShortcutAction.undo,
  //         [
  //           ShortcutKey.systemCmd,
  //           ShortcutKey.z,
  //         ],
  //       ),
  //       Shortcut(
  //         ShortcutAction.redo,
  //         [
  //           ShortcutKey.shift,
  //           ShortcutKey.systemCmd,
  //           ShortcutKey.z,
  //         ],
  //       ),
  //     ],
  //   );

  //   // Shortcut system automatically determines which command key to use based
  //   // on platform, so let's similarly pick the appropriate one that maps our
  //   // abstraction to check for.
  //   var systemCommandKeyLeft = Platform.instance.isMac
  //       ? PhysicalKeyboardKey.metaLeft
  //       : PhysicalKeyboardKey.controlLeft;

  //   var systemCommandKeyRight = Platform.instance.isMac
  //       ? PhysicalKeyboardKey.metaRight
  //       : PhysicalKeyboardKey.controlRight;
  //   // Verify that key chords resolve to expected actions
  //   expect(
  //     keyBinding.lookupAction(
  //       [
  //         systemCommandKeyLeft,
  //         PhysicalKeyboardKey.keyC,
  //       ],
  //     ),
  //     [
  //       ShortcutAction.copy,
  //     ],
  //   );

  //   // Out of order works too
  //   expect(
  //     keyBinding.lookupAction(
  //       [
  //         PhysicalKeyboardKey.keyC,
  //         systemCommandKeyLeft,
  //       ],
  //     ),
  //     [
  //       ShortcutAction.copy,
  //     ],
  //   );

  //   // Either left or right key...
  //   expect(
  //     keyBinding.lookupAction(
  //       [
  //         systemCommandKeyRight,
  //         PhysicalKeyboardKey.keyC,
  //       ],
  //     ),
  //     [
  //       ShortcutAction.copy,
  //     ],
  //   );

  //   // Out of order works too
  //   expect(
  //     keyBinding.lookupAction(
  //       [
  //         PhysicalKeyboardKey.shiftLeft,
  //         systemCommandKeyRight,
  //         PhysicalKeyboardKey.keyZ,
  //       ],
  //     ),
  //     [
  //       ShortcutAction.redo,
  //     ],
  //   );
  // });
}
