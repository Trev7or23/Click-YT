

[API]  1 issues
  X 1 print in production

[PERFORMANCE]  23 issues
  X 23 widgets missing const

[UI]  15 issues
  X 10 inline text style
  X 1 hardcoded size
  X 4 missing key in list

[ARCHITECTURE]  2 issues
  X 2 huge build method

[QUALITY]  2 issues
  X 2 long method

------------------------------------------------------------
TOP 5 ISSUES TO FIX FIRST
------------------------------------------------------------
  1. WARNING   lib/providers/download_provider.dart:16
     `DownloadService` can be marked const
     Add the const keyword: `const DownloadService(...)`

  2. WARNING   lib/components/ui/app_snack_bar.dart:30
     `BorderRadius.circular` can be marked const
     Add the const keyword: `const BorderRadius.circular(...)`

  3. WARNING   lib/components/download_modal.dart:64
     `BorderRadius.circular` can be marked const
     Add the const keyword: `const BorderRadius.circular(...)`

  4. WARNING   lib/components/download_modal.dart:68
     `Text` can be marked const
     Add the const keyword: `const Text(...)`

  5. WARNING   lib/components/download_modal.dart:126
     `StyledText` can be marked const
     Add the const keyword: `const StyledText(...)`

