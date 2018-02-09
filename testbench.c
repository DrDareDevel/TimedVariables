#include <stdio.h>
#include <time.h>

typedef struct {
   unsigned long long    data;
   unsigned long long    timeStamp;
} timedVariable;

int main(void) {

    double diffs[1000000];
    struct timespec start, stop;
    timedVariable test = { 0, 0 };
    int i;
    unsigned long long start_time, end_time;
    clock_gettime( CLOCK_REALTIME, &start);
    start_time = (unsigned long long) start.tv_nsec;
    for(i = 0; i < 1000000; i++){
        clock_gettime( CLOCK_REALTIME, &start);
        test.data = (unsigned long long) start.tv_nsec;
        clock_gettime( CLOCK_REALTIME, &stop);
        test.timeStamp = (unsigned long long) stop.tv_nsec;
        diffs[i] = ((double)(test.timeStamp - test.data));
    }
    clock_gettime( CLOCK_REALTIME, &stop);
    end_time = (unsigned long long) stop.tv_nsec;
    printf("Time Taken: %f\n", (double) (end_time - start_time));
    for(i = 0; i < 1000000; i++)
        printf("%lf\n", diffs[i]);

    return 0;
}
