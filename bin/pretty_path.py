"""Pretty path."""

import sys


def string_to_list(text: str) -> list:
    ret = []
    buff = ""

    for i, char in enumerate(text):
        if i == len(text) - 1:
            buff += char
            ret.append(buff)

        if char == ":":
            ret.append(buff)
            buff = ""

        else:
            buff += char

    return ret


def check_dublicate(text: list) -> list:
    ret = []
    cache = []

    for item in text:
        if item in cache:
            ret.append(item)
        else:
            cache.append(item)

    return ret


def printout_pretty_string(text: list, dubl=[]) -> None:
    print("Entries:")
    for item in text:
        print(f"\t{item}")

    if dubl:
        print("\nDublicates:")
        for item in dubl:
            print(f"\t{item}")

    # Summary
    if not dubl:
        print(f"\nTotal: {len(text)}")
    else:
        print(f"\nTotal: {len(text)} ({len(dubl)} dublicates)")


def main():
    try:
        arg_list = string_to_list(sys.argv[1])
        arg_dubl = check_dublicate(arg_list)
        printout_pretty_string(arg_list, arg_dubl)

    except Exception:
        print("usage: python pretty_path <PATH>")


if __name__ == "__main__":
    main()
