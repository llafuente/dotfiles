## Find components on active GameObjects:

> BaseClass[] components = GameObject.FindObjectsOfType<BaseClass>();

## Find all components on active and inactive GameObjects:

> BaseClass[] components = Resources.FindObjectsOfTypeAll<BaseClass>();


# debug projects

https://github.com/needle-tools/compilation-visualizer


# setter and getters serialization
```dotnet
[field: SerializeField]
public float startTimeScale { get, protected set} = 1.0f;
```
