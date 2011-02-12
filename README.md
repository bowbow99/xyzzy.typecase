これは何
========
Common Lisp の `typecase` やらなんやら（作り始めた）。

参考リンク
----------
- [CLHS: Macro TYPECASE, CTYPECASE, ETYPECASE][1]

  [1]: http://www.lispworks.com/documentation/HyperSpec/Body/m_tpcase.htm

依存するライブラリ
==================
- condition-restart
- typespec+

インストール
============

NetInstaller から
-----------------
<del>[カフェイン中毒] からどうぞ。</del>

  [カフェイン中毒]: http://bowbow99.sakura.ne.jp/xyzzy/packages.l

設定
====
特になし？

使い方
======

    (eval-when (:load-toplevel :compile-toplevel :execute)
      (require "typecase"))

注意点、既知の問題など
======================
- 何も実装されてない

バグ報告、質問、要望などは [GitHubIssues] か [@bowbow99] あたりへお願いします。

  [GitHubIssues]: http://github.com/bowbow99/xyzzy.typecase/issues
  [@bowbow99]: http://twitter.com/bowbow99
