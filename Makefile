SHELL = /bin/sh
CC = crystal build
BUILD_DIR = build
OUT_FILE = ${BUILD_DIR}/bench
SOURCE_FILES = src/bench.cr

build_and_run: clean run

clean:
	if [ ! -d "./${BUILD_DIR}" ]; then mkdir "${BUILD_DIR}"; else env echo "cleaning..." && rm -r ${BUILD_DIR}; mkdir "${BUILD_DIR}"; fi

build_test:
	${CC} ${SOURCE_FILES} -o ${OUT_FILE}_test.o --error-trace

test: build_test
	./${OUT_FILE}_test.o

${OUT_FILE}:
	${CC} ${SOURCE_FILES} -o ${OUT_FILE}.o --release --no-debug

run: ${OUT_FILE}
	./${OUT_FILE}.o
