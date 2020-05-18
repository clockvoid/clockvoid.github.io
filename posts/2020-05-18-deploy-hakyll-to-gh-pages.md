---
title: Hakyllで作ったサイトをGitHub Pagesにデプロイする
summary: |
  HakyllはHaskell製の静的サイトジェネレータです．
  よくWeb上に転がっているCircle CIでのビルドではうまく行かなかったので，GitHub Actionsを使ってデプロイを行う方法を示します．
---

# Circle CIで何が起こったか
私はこのブログをHakyllを使って作っています．HakyllはHaskell製の静的サイトジェネレータですが，初期ビルドに非常に時間を要します．
例えば，私が今使っているMacBook Pro 13inch 2018（Core i7，16GB Memory）では15分ほどを要します．
これは，Hakyllが依存するライブラリが非常に多い上に，GHCがそもそも遅く，メモリも食うためであると想像しています．

このようなものをCircle CIのFreeプランでビルドしようとすると，OOMします．
実際に，私のサイトをCircle CIでデプロイ仕様とした際，OOMに悩まされました．初期ビルドが通らなければ，キャッシュもされず，永遠にビルドが通らない状況に陥ります．

Circle CIのFreeプランではメモリ4GB，2CPUのコンテナが使用できますが，これでは足りないということなのでしょう．

そこで，私はGitHub Actionsに目をつけました．これならば比較的新しい上に無料プランでも一ヶ月あたり2,000時間分の枠が用意されているため，比較的ラフに使用することができるはずです．

# GitHub Actions
[GitHub ActionsのBillingページ](https://help.github.com/en/github/setting-up-and-managing-billing-and-payments-on-github/about-billing-for-github-actions)に行くとフリープランでは一ヶ月あたり1GB，500MBのキャッシュ用のストレージが用意されているということになっています．
しかし，搭載しているメモリがどれくらいの量なのか定かではありません．

通るのかわかりませんが，恐る恐る実行してみると，[41分かかって通りました](https://github.com/clockvoid/portfolio/actions/runs/107149520)．この時間の殆どはHakyllの依存関係解決に費やされています．

# 具体的な使い方
ビルドが成功することはわかったので，具体的な使い方を見ていきます．

まず，GitHubのプロジェクトページの一番上にあるタブからActionsタブをクリックします．
![](https://i.imgur.com/eG9gNcC.png)

Actionタブを開くと，GitHubのレポジトリの主要言語から使用するワークフローの雛形を作ってくれます．とても便利です．
基本的には，この雛形から自分の用途にあうように編集するだけで簡単にデプロイができるようになります．