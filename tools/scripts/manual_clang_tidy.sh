#!/bin/bash
# Run clang-tidy on all .cpp files in the project, ignoring Qt warnings

CODEBASE_PATH="."
QT_INCLUDE_PATH="${QT_INCLUDE_PATH:-/path/to/your/Qt/include}"
PROJECT_ROOT="$(pwd)"

# List of clang-tidy checks to ignore for Qt/C++ projects
IGNORED_CHECKS="-llvmlibc-restrict-system-libc-headers,-llvmlibc-callee-namespace,-llvmlibc-implementation-in-namespace"

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
