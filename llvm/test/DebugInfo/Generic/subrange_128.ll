;; Check output of DISubrangeType with 128-bit values.

; AIX doesn't currently support DWARF 5.
; XFAIL: target={{.*}}-zos{{.*}}, target={{.*}}-aix{{.*}}

; RUN: %llc_dwarf -filetype=obj --dwarf-version=5 -O0 < %s | llvm-dwarfdump -debug-info - | FileCheck %s

; CHECK: DW_TAG_array_type
; CHECK-NEXT: DW_AT_type{{.*}}"()"
; CHECK-NOT: NULL
; CHECK: DW_TAG_subrange_type
; CHECK-NOT: NULL
; CHECK-NEXT: DW_AT_lower_bound (05050505050505050505050505050505)
; CHECK-NEXT: DW_AT_count (03030303030303030303030303030303)
; CHECK: DW_TAG_subrange_type
; CHECK-NOT: NULL
; CHECK-NEXT: DW_AT_lower_bound (07070707070707070707070707070707)
; CHECK-NEXT: DW_AT_upper_bound (09090909090909090909090909090909)

; ModuleID = 'subrange.ll'
source_filename = "/dir/subrange.o"

!llvm.module.flags = !{!0, !1}
!llvm.dbg.cu = !{!2}

!0 = !{i32 7, !"Dwarf Version", i32 4}
!1 = !{i32 2, !"Debug Info Version", i32 3}
!2 = distinct !DICompileUnit(language: DW_LANG_Rust, file: !3, producer: "clang LLVM (rustc version 1.102.0-nightly (20fe935d5 2026-11-23))", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, globals: !4, retainedTypes: !12, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "subrange.o", directory: "/dir")
!4 = !{}
!5 = distinct !DISubprogram(name: "sr", scope: !3, file: !3, type: !6, scopeLine: 1, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !8)
!6 = !DISubroutineType(types: !7)
!7 = !{null}
!8 = !{!10, !11}
!9 = !DIBasicType(name: "()", encoding: DW_ATE_unsigned)
!10 = !DILocalVariable(name: "x", scope: !5, file: !3, line: 2, type: !13, align: 1)
!11 = !DILocalVariable(name: "y", scope: !5, file: !3, line: 3, type: !16, align: 1)
!12 = !{!13, !16}

!13 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, align: 8, elements: !14)
!14 = !{!15}
!15 = !DISubrange(count: i128 03030303030303030303030303030303, lowerBound: i128 05050505050505050505050505050505)

!16 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, align: 8, elements: !17)
!17 = !{!18}
!18 = !DISubrange(lowerBound: i128 07070707070707070707070707070707, upperBound: i128 09090909090909090909090909090909)
