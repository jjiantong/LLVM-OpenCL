; ModuleID = 'matrixMult.cl'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600"

@matrixMult.A_local = internal addrspace(3) unnamed_addr global [64 x [64 x float]] zeroinitializer, align 4
@matrixMult.B_local = internal addrspace(3) unnamed_addr global [64 x [64 x float]] zeroinitializer, align 4

; Function Attrs: nounwind
define void @matrixMult(float addrspace(1)* noalias nocapture %C, float addrspace(1)* nocapture readonly %A, float addrspace(1)* nocapture readonly %B, i32 %A_width, i32 %B_width) #0 {
  %1 = tail call i32 @get_group_id(i32 0) #2
  %2 = tail call i32 @get_group_id(i32 1) #2
  %3 = tail call i32 @get_local_id(i32 0) #2
  %4 = tail call i32 @get_local_id(i32 1) #2
  %5 = shl nsw i32 %A_width, 6
  %6 = mul nsw i32 %2, %5
  %7 = add i32 %A_width, -1
  %8 = add i32 %7, %6
  %9 = icmp sgt i32 %6, %8
  br i1 %9, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %0
  %10 = shl nsw i32 %1, 6
  %11 = mul nsw i32 %4, %A_width
  %12 = add i32 %11, %3
  %13 = getelementptr inbounds [64 x [64 x float]] addrspace(3)* @matrixMult.A_local, i32 0, i32 %4, i32 %3
  %14 = mul nsw i32 %4, %B_width
  %15 = add i32 %14, %3
  %16 = getelementptr inbounds [64 x [64 x float]] addrspace(3)* @matrixMult.B_local, i32 0, i32 %3, i32 %4
  %17 = shl i32 %B_width, 6
  br label %18

; <label>:18                                      ; preds = %.lr.ph, %33
  %b.05 = phi i32 [ %10, %.lr.ph ], [ %35, %33 ]
  %a.04 = phi i32 [ %6, %.lr.ph ], [ %34, %33 ]
  %running_sum.03 = phi float [ 0.000000e+00, %.lr.ph ], [ %31, %33 ]
  %19 = add i32 %12, %a.04
  %20 = getelementptr inbounds float addrspace(1)* %A, i32 %19
  %21 = load float addrspace(1)* %20, align 4, !tbaa !3
  store float %21, float addrspace(3)* %13, align 4, !tbaa !3
  %22 = add i32 %15, %b.05
  %23 = getelementptr inbounds float addrspace(1)* %B, i32 %22
  %24 = load float addrspace(1)* %23, align 4, !tbaa !3
  store float %24, float addrspace(3)* %16, align 4, !tbaa !3
  tail call void @barrier(i32 1) #2
  br label %25

; <label>:25                                      ; preds = %25, %18
  %k.02 = phi i32 [ 0, %18 ], [ %32, %25 ]
  %running_sum.11 = phi float [ %running_sum.03, %18 ], [ %31, %25 ]
  %26 = getelementptr inbounds [64 x [64 x float]] addrspace(3)* @matrixMult.A_local, i32 0, i32 %4, i32 %k.02
  %27 = load float addrspace(3)* %26, align 4, !tbaa !3
  %28 = getelementptr inbounds [64 x [64 x float]] addrspace(3)* @matrixMult.B_local, i32 0, i32 %3, i32 %k.02
  %29 = load float addrspace(3)* %28, align 4, !tbaa !3
  %30 = fmul float %27, %29
  %31 = fadd float %running_sum.11, %30
  %32 = add nsw i32 %k.02, 1
  %exitcond = icmp eq i32 %32, 64
  br i1 %exitcond, label %33, label %25

; <label>:33                                      ; preds = %25
  tail call void @barrier(i32 1) #2
  %34 = add nsw i32 %a.04, 64
  %35 = add nsw i32 %b.05, %17
  %36 = icmp sgt i32 %34, %8
  br i1 %36, label %._crit_edge, label %18

._crit_edge:                                      ; preds = %33, %0
  %running_sum.0.lcssa = phi float [ 0.000000e+00, %0 ], [ %31, %33 ]
  %37 = tail call i32 @get_global_id(i32 1) #2
  %38 = tail call i32 @get_global_size(i32 0) #2
  %39 = mul i32 %38, %37
  %40 = tail call i32 @get_global_id(i32 0) #2
  %41 = add i32 %39, %40
  %42 = getelementptr inbounds float addrspace(1)* %C, i32 %41
  store float %running_sum.0.lcssa, float addrspace(1)* %42, align 4, !tbaa !3
  ret void
}

declare i32 @get_group_id(i32) #1

declare i32 @get_local_id(i32) #1

declare void @barrier(i32) #1

declare i32 @get_global_id(i32) #1

declare i32 @get_global_size(i32) #1

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!opencl.kernels = !{!0}
!llvm.ident = !{!2}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, float addrspace(1)*, i32, i32)* @matrixMult, metadata !1}
!1 = metadata !{metadata !"reqd_work_group_size", i32 64, i32 64, i32 1}
!2 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3~precise2 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!3 = metadata !{metadata !4, metadata !4, i64 0}
!4 = metadata !{metadata !"float", metadata !5, i64 0}
!5 = metadata !{metadata !"omnipotent char", metadata !6, i64 0}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}
