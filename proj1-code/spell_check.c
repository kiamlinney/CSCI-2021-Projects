#include <ctype.h>
#include <stdio.h>
#include <string.h>

#include <stdlib.h> // Used for exit(0)

#include "dictionary.h"

#define MAX_CMD_LEN 128

// A helper function to spell check a specific file
// 'file_name': Name of the file to spell check
// 'dict': A dictionary containing correct words

int spell_check_file(const char *file_name, const dictionary_t *dict) {
    FILE *f = fopen(file_name, "r");

    if(f == NULL || dict == NULL){
        printf("Spell check failed\n");
        return -1;
    }

    char word[MAX_WORD_LEN];
    char line[1024]; 

    while(fgets(line, sizeof(line), f)){
        char *ptr = line;
        
        while(sscanf(ptr, "%s", word) == 1){
            if(dict_find(dict, word) == 1)
                printf("%s ", word);
            else 
                printf("%s[X] ", word);

            // Move ptr to next word, as sscanf stops when it encounters a whitespace character
            ptr += strlen(word);
            // Accounts for more than one whitespace character, ensures ptr starts at next word
            while (isspace(*ptr))
                ptr++;
            
        }
        printf("\n");
    }

    fclose(f);
    return 0;
}

/*
 * This is in general *very* similar to the list_main file seen in lab
 */
int main(int argc, char **argv) {
    dictionary_t *dict = NULL;
    char cmd[MAX_CMD_LEN];

    dict = create_dictionary();

    if(argc > 1){
        char *dict_name = argv[1];

        dictionary_t *new_dict = read_dict_from_text_file(dict_name);
        
        if(new_dict == NULL){
            printf("Failed to read dictionary from text file\n");
            exit(0);
        }
        else {
            printf("Dictionary successfully read from text file\n");
            dict_free(dict);
            dict = new_dict;
        }

        if(argc > 2){
            char *file_name = argv[2];
            spell_check_file(file_name, dict);
            exit(0);
        }
    }

    printf("CSCI 2021 Spell Check System\n");
    printf("Commands:\n");
    printf("  add <word>:              adds a new word to dictionary\n");
    printf("  lookup <word>:           searches for a word\n");
    printf("  print:                   shows all words currently in the dictionary\n");
    printf("  load <file_name>:        reads in dictionary from a file\n");
    printf("  save <file_name>:        writes dictionary to a file\n");
    printf("  check <file_name>: spell checks the specified file\n");
    printf("  exit:                    exits the program\n"); 

    while (1) {
        printf("spell_check> ");
        if (scanf("%s", cmd) == EOF) {
            printf("\n");
            break;
        }

        if (strcmp("exit", cmd) == 0) {
            break;
        }

        else if(strcmp("add", cmd) == 0){
            char word[MAX_WORD_LEN];
            if (scanf(" %s", word) == EOF) {
                printf("\n");
                break;
            }
            dict_insert(dict, word);
        }

        else if(strcmp("lookup", cmd) == 0){
            char word[MAX_WORD_LEN];
            if (scanf("%s", word) == EOF) {
                printf("\n");
                break;
            }
            if(dict_find(dict, word) == 1){
                printf("'%s' present in dictionary\n", word);
            }
            else{
                printf("'%s' not found\n", word);
            }
        }
        
        else if(strcmp("print", cmd) == 0){
            dict_print(dict);
        }

        else if(strcmp("load", cmd) == 0){
            char file_name[MAX_WORD_LEN];

            if (scanf("%s", file_name) == EOF) {
                printf("\n");
                break;
            }

            dictionary_t *new_dict = read_dict_from_text_file(file_name);

            if(new_dict == NULL){
                printf("Failed to read dictionary from text file\n");
            }
            else if(new_dict != NULL){
                printf("Dictionary successfully read from text file\n");
                dict_free(dict);
                dict = new_dict;
            }
            
        }

        else if(strcmp("save", cmd) == 0){
            char file_name[MAX_WORD_LEN];

            if (scanf("%s", file_name) == EOF) {
                printf("\n");
                break;
            }

            if(write_dict_to_text_file(dict, file_name) == 0){
                printf("Dictionary successfully written to text file\n");
            }
            else {
                printf("Failed to write dictionary to text file\n");
            }
        }

        else if(strcmp("check", cmd) == 0){
            char file_name[MAX_WORD_LEN];
            if (scanf("%s", file_name) == EOF) {
                printf("\n");
                break;
            }

            spell_check_file(file_name, dict);
        }
        
        else {
            printf("Unknown command %s\n", cmd);
        }
    }

    dict_free(dict);
    return 0;
}