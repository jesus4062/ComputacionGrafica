using System;
using UnityEditor;
using UnityEngine;

[Serializable]
struct FloatCurve
{
    public string materialProperty;
    private AnimationCurve curve;
}

[RequireComponent(typeof(ParticleSystem))]
[ExecuteInEditMode]

public class MaterialAnimator : MonoBehaviour
{
    [SerializeField] private Material targetmaterial; 
    
    private  ParticleSystem particles;
    [SerializeField] private FloatCurve[] curves;

    [SerializeField] private float particleTime;
    private void Awake()
    {
        particles = GetComponent<ParticleSystem>();
    }

    void Evaluate()
    {
        particleTime = particles.time;
        foreach (FloatCurve CURVE in curves)
        {
            targetmaterial.SetFloat(curve.materialProperty,curve.curve.Evualuate(particleTime));
        }
    }

    private void Update()
    {
        
    }
}
