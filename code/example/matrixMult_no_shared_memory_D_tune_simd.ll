; ModuleID = 'matrixMult_no_shared_memory_D_tune_simd.cl'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-v2048:2048:2048-n32:64"
target triple = "r600"

; Function Attrs: nounwind
define void @matrixMult(float addrspace(1)* noalias nocapture %C, float addrspace(1)* noalias nocapture readonly %A, float addrspace(1)* noalias nocapture readonly %B, i32 %A_width, i32 %B_width) #0 {
  %1 = tail call i32 @get_global_id(i32 0) #2
  %2 = tail call i32 @get_global_id(i32 1) #2
  %3 = tail call i32 @get_global_size(i32 0) #2
  %4 = tail call i32 @get_global_size(i32 1) #2
  %5 = shl nsw i32 %2, 11
  br label %6

; <label>:6                                       ; preds = %6, %0
  %j.02 = phi i32 [ 0, %0 ], [ %15, %6 ]
  %value.01 = phi float [ 0.000000e+00, %0 ], [ %14, %6 ]
  %.sum = add i32 %j.02, %5
  %7 = getelementptr inbounds float addrspace(1)* %A, i32 %.sum
  %8 = load float addrspace(1)* %7, align 4, !tbaa !3
  %9 = mul nsw i32 %j.02, %B_width
  %10 = add nsw i32 %9, %1
  %11 = getelementptr inbounds float addrspace(1)* %B, i32 %10
  %12 = load float addrspace(1)* %11, align 4, !tbaa !3
  %13 = fmul float %8, %12
  %14 = fadd float %value.01, %13
  %15 = add nsw i32 %j.02, 1
  %exitcond = icmp eq i32 %15, 2048
  br i1 %exitcond, label %16, label %6

; <label>:16                                      ; preds = %6
  %17 = add nsw i32 %5, %1
  %18 = getelementptr inbounds float addrspace(1)* %C, i32 %17
  store float %14, float addrspace(1)* %18, align 4, !tbaa !3
  ret void
}

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
