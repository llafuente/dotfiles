# std::vector

## declarations

    int arr[] = {2,5,8,11,14};
    std::vector<int> TestVector(arr, arr+5);

C++11

    std::vector<int> v{2,5,8,11,14};
    std::vector<int> v = {2,5,8,11,14};

## concat

    destination.insert(std::end(destination), std::begin(source), std::end(source));

    std::copy(source.begin(), source.end(), std::back_inserter(destination));

C++11

    std::move(b.begin(), b.end(), std::back_inserter(a));
