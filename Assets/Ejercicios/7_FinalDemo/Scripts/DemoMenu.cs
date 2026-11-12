using UnityEngine;
using UnityEngine.Playables;

public class DemoMenu : MonoBehaviour
{
    [SerializeField] private PlayableDirector kamehameha;
    [SerializeField] private PlayableDirector makankosappo;

    private PlayableDirector selected;

    private void Awake()
    {
        selected = kamehameha;
    }

    public void SelectKamehameha()
    {
        PlayFromStart(kamehameha);
    }

    public void SelectMakankosappo()
    {
        PlayFromStart(makankosappo);
    }

    private void PlayFromStart(PlayableDirector next)
    {
        if (next == null)
            return;

        if (selected != null && selected != next)
            selected.Stop();

        selected = next;
        selected.Stop();
        selected.time = 0;
        selected.Play();
    }

    public void TogglePlayPause()
    {
        if (selected == null)
            return;

        if (selected.playableGraph.IsValid() && selected.time < selected.duration)
        {
            if (selected.state == PlayState.Playing)
                selected.Pause();
            else
                selected.Resume();

            return;
        }

        PlayFromStart(selected);
    }
}