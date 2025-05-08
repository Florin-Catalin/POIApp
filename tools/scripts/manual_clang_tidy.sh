#!/bin/bash
# Run clang-tidy on all .cpp files in the project, ignoring Qt warnings

CODEBASE_PATH="."
QT_INCLUDE_PATH="${QT_INCLUDE_PATH:-/path/to/your/Qt/include}"
PROJECT_ROOT="$(pwd)"

# List of clang-tidy checks to ignore for Qt/C++ projects
IGNORED_CHECKS=""
# Not relevant for application code, only for LLVM libc development
IGNORED_CHECKS="$IGNORED_CHECKS,-llvmlibc-restrict-system-libc-headers"
# Not relevant for application code, only for LLVM libc development
IGNORED_CHECKS="$IGNORED_CHECKS,-llvmlibc-callee-namespace"
# Not relevant for application code, only for LLVM libc development
IGNORED_CHECKS="$IGNORED_CHECKS,-llvmlibc-implementation-in-namespace"
# Trailing return type is a style preference, not required for Qt/C++
IGNORED_CHECKS="$IGNORED_CHECKS,-modernize-use-trailing-return-type"
# Fuchsia style guide is not enforced in this project
IGNORED_CHECKS="$IGNORED_CHECKS,-fuchsia-trailing-return"
IGNORED_CHECKS="$IGNORED_CHECKS,-fuchsia-default-arguments-calls"


for file in $(find "$CODEBASE_PATH" -path "$CODEBASE_PATH/build" -prune -o -name "*.cpp" -print); do
    echo "Checking $file"
    clang-tidy "$file" -checks=*,${IGNORED_CHECKS} --header-filter="^$PROJECT_ROOT/" -- \
        -I "$CODEBASE_PATH" \
        -isystem "$QT_INCLUDE_PATH" \
        -isystem "$QT_INCLUDE_PATH/QtCore" \
        -isystem "$QT_INCLUDE_PATH/QtGui" \
        -isystem "$QT_INCLUDE_PATH/QtWidgets" \
        -isystem "$QT_INCLUDE_PATH/QtNetwork" \
        -isystem "$QT_INCLUDE_PATH/QtQml" \
        -std=c++17
done
